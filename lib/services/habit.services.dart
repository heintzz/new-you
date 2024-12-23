import 'package:remindme/data/habit.dart';
import 'package:remindme/model/habit_model.dart';

class HabitServices {
  static final List<HabitTask> _tasks = dummyHabitTasks;

  // CREATE
  static Future<void> createHabit({required HabitTask task}) async {
    _tasks.add(task);
  }

  // READ
  static List<HabitTask> getHabits({required DateTime date}) {
    // ambil yang hari ini
    final todayHabits = _tasks.where((task) {
      final isOnTheSameDay = task.createdAt.year == date.year &&
          task.createdAt.month == date.month &&
          task.createdAt.day == date.day;
      return isOnTheSameDay;
    }).toList();

    // habit yang repeated
    final dummyHabit = _tasks.where((task) {
      return (task.type == HabitType.habit) &&
          (task.parentId == null) &&
          date.isAfter(task.createdAt);
    }).toList();

    // daftar parentId dari todayHabits
    final todayParentIds = todayHabits
        .map((habit) => habit.parentId.toString())
        .whereType<String>()
        .toSet();

    final today = DateTime.now();

    final sameDay = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
    final nextDay = date.year >= today.year &&
        date.month >= today.month &&
        date.day > today.day;

    // omit semua yang udah ada "penerusnya" ubah completionId sesuai rule
    final filteredDummyHabit = dummyHabit.where((habit) {
      return !todayParentIds.contains(habit.id);
    }).map((habit) {
      return HabitTask(
        id: habit.id,
        title: habit.title,
        type: habit.type,
        createdAt: habit.createdAt,
        parentId: habit.parentId,
        category: habit.category,
        completionId: sameDay
            ? CompletionType.pending
            : (nextDay ? CompletionType.lock : habit.completionId),
      );
    }).toList();

    final filteredHabits = [...todayHabits, ...filteredDummyHabit];
    return filteredHabits;
  }

  static void updateCompletionStatus(
      {required HabitTask task, required DateTime date}) {
    if (task.completionId == CompletionType.lock) {
      return;
    }

    if (task.type != HabitType.habit) {
      task.completionId = getNextStatus(task.completionId);
      return;
    }

    final isOnTheSameDay = task.createdAt.year == date.year &&
        task.createdAt.month == date.month &&
        task.createdAt.day == date.day;

    if (!isOnTheSameDay) {
      _tasks.add(HabitTask(
        id: generateUniqueId(),
        title: task.title,
        type: task.type,
        createdAt: date,
        category: task.category,
        completionId: getNextStatus(CompletionType.pending),
        parentId: task.id,
      ));
    } else {
      task.completionId = getNextStatus(task.completionId);
    }
  }

  // UPDATE
  static Future<void> updateHabit(String id, HabitTask updatedTask) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  // DELETE
  static Future<void> deleteHabit(String id) async {
    _tasks.removeWhere((task) => task.id == id);
  }
}
