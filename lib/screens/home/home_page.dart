import 'package:flutter/material.dart';
import 'package:remindme/data/habit.dart';
import 'package:remindme/model/date.dart';
import 'package:remindme/model/habit_model.dart';
import 'package:remindme/screens/add_habit/add_habit_page.dart';
import 'package:remindme/screens/home/habit_card.dart';
import 'package:remindme/screens/home/horizontal_date.dart';
import 'package:remindme/services/habit.services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);
  late List<HabitTask> _habitTasks;

  @override
  void initState() {
    super.initState();
    _habitTasks = HabitServices.getHabits(date: selectedDate);
  }

  Future<void> _refreshHabits() async {
    setState(() {
      _habitTasks = HabitServices.getHabits(date: selectedDate);
    });
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
        dummyHabitTasks.add(HabitTask(
          id: generateUniqueId(),
          title: task.title,
          type: task.type,
          createdAt: selectedDate,
          category: task.category,
          completionId: getNextStatus(CompletionType.pending),
          parentId: task.id,
        ));
      } else {
        task.completionId = getNextStatus(task.completionId);
      }

      _refreshHabits();
    });
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
                    _refreshHabits();
                  });
                },
              ),
            ),

            // List Habit
            HabitList(
                tasks: _habitTasks, onStatusChange: _changeCompletionStatus)
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
