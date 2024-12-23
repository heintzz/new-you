import 'package:remindme/model/habit_model.dart';

final List<HabitTask> dummyHabitTasks = [
  HabitTask(
      id: '1',
      title: 'Morning Exercise',
      completionId: CompletionType.done,
      type: HabitType.habit,
      category: "exercise",
      createdAt: DateTime.now()),
  HabitTask(
    id: '2',
    title: 'Read Books',
    completionId: CompletionType.pending,
    type: HabitType.habit,
    category: "study",
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
];
