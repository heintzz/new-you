import 'package:flutter/material.dart';
import 'package:remindme/model/date.dart';
import 'package:remindme/model/habit_model.dart';
import 'package:remindme/screens/home/add_button.dart';
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
    HabitServices.updateCompletionStatus(task: task, date: selectedDate);
    _refreshHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            HorizontalDate(
              currentDate: selectedDate,
              onDateSelected: (DateTime newDate) {
                setState(() {
                  selectedDate = newDate;
                  _refreshHabits();
                });
              },
            ),

            // List Habit
            HabitList(
                tasks: _habitTasks, onStatusChange: _changeCompletionStatus)
          ],
        ),
      ),
      floatingActionButton: AddButton(),
    );
  }
}
