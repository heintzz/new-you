import 'package:flutter/material.dart';
import 'package:remindme/data/habit.dart';
import 'package:remindme/model/date.dart';
import 'package:remindme/model/habit_model.dart';
import 'package:remindme/screens/add_habit/add_habit_page.dart';
import 'package:remindme/screens/home/habit_card.dart';
import 'package:remindme/screens/home/horizontal_date.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);
  List<HabitTask> filteredTasks = [];

  String generateUniqueId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  void _changeCompletionStatus(HabitTask task) {
    if (task.completionId == CompletionType.lock) {
      return;
    }

    setState(() {
      if (task.type != HabitType.habit) {
        task.completionId = getNextStatus(task.completionId);
        return;
      }

      // Jika task adalah habit
      final isOnTheSameDay = task.createdAt.year == selectedDate.year &&
          task.createdAt.month == selectedDate.month &&
          task.createdAt.day == selectedDate.day;

      if (!isOnTheSameDay) {
        // create a copy -> TODO: implement to database
        dummyHabitTasks.add(HabitTask(
          id: generateUniqueId(),
          title: task.title,
          type: task.type,
          createdAt: selectedDate,
          completionId: getNextStatus(CompletionType.pending),
          parentId: task.id,
        ));
      } else {
        task.completionId = getNextStatus(task.completionId);
      }

      filteredTasks = _filterTasks(dummyHabitTasks);
    });
  }

  List<HabitTask> _filterTasks(List<HabitTask> tasks) {
    // filter today
    //  - task and habit today
    // filter yang habit
    //  - create a copy on this selected date for habit that has lesser createdAt
    // merge those two array

    final todayHabits = tasks.where((task) {
      final isOnTheSameDay = task.createdAt.year == selectedDate.year &&
          task.createdAt.month == selectedDate.month &&
          task.createdAt.day == selectedDate.day;
      return isOnTheSameDay;
    }).toList();

    // dummy habit
    final dummyHabit = tasks.where((task) {
      return (task.type == HabitType.habit) &&
          (task.parentId == null) &&
          selectedDate.isAfter(task.createdAt);
    }).toList();

    // daftar parentId dari todayHabits
    final todayParentIds = todayHabits
        .map((habit) => habit.parentId.toString())
        .whereType<String>()
        .toSet();

    final today = DateTime.now();

    final sameDay = selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day;
    final nextDay = selectedDate.year >= today.year &&
        selectedDate.month >= today.month &&
        selectedDate.day > today.day;

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
        completionId: sameDay
            ? CompletionType.pending
            : (nextDay ? CompletionType.lock : habit.completionId),
      );
    }).toList();

    final filteredHabits = [...todayHabits, ...filteredDummyHabit];
    return filteredHabits;
  }

  @override
  void initState() {
    super.initState();
    filteredTasks = _filterTasks(dummyHabitTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Center(
      //       child: Text(
      //     "findyou",
      //     style: TextStyle(color: Colors.white),
      //   )),
      //   elevation: 0,
      //   toolbarHeight: 62,
      //   backgroundColor: Colors.deepPurple.shade300,
      // ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Tanggal
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Text("Today",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Text(DateModel.getFullDateString(selectedDate)),
                ],
              ),
            ),

            // Milih Tanggal
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: HorizontalDate(
                currentDate: selectedDate,
                onDateSelected: (DateTime newDate) {
                  setState(() {
                    selectedDate = newDate;
                    filteredTasks = _filterTasks(dummyHabitTasks);
                  });
                },
              ),
            ),

            // List Habit
            HabitList(
                tasks: filteredTasks, onStatusChange: _changeCompletionStatus)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddHabitPage()));
          // showModalBottomSheet(
          //   context: context,
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          //   ),
          //   builder: (BuildContext context) {
          //     return Container(
          //       height: 200,
          //       padding: const EdgeInsets.all(16),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text(
          //             'This is a Bottom Drawer',
          //             style:
          //                 TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //           ),
          //           const SizedBox(height: 10),
          //           const Text(
          //               'You can add any content here, such as forms, lists, or buttons.'),
          //           const SizedBox(height: 20),
          //           ElevatedButton(
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //             child: const Text('Close'),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
