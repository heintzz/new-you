import 'package:flutter/material.dart';
import 'package:remindme/model/habit_model.dart';
import 'package:remindme/screens/add_habit/category.dart';
import 'package:remindme/screens/main_activity.dart';
import 'package:remindme/services/habit.services.dart';

class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        child: HabitInput(),
      ),
    ));
  }
}

class HabitInput extends StatefulWidget {
  HabitInput({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HabitInputState createState() => _HabitInputState();
}

class _HabitInputState extends State<HabitInput> {
  String _title = "";
  String _selectedCategory = "";

  void _backToHome(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainActivity()));
  }

  @override
  Widget build(BuildContext context) {
    // _databaseService.printHabit();
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                TextField(
                  onChanged: (String value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task',
                  ),
                ),
                InkWell(
                    onTap: () => _dialogBuilder(context),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(children: [
                            Icon(Icons.category_outlined),
                            SizedBox(width: 5),
                            Text("Category")
                          ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(_selectedCategory),
                                SizedBox(width: 5),
                                Icon(Icons.access_time)
                              ]),
                        ],
                      ),
                    )),
              ],
            )),
        bottomNavigationBar: Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                _backToHome(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            )),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_title.isNotEmpty & _selectedCategory.isNotEmpty) {
                    final HabitTask newHabit = HabitTask(
                        id: generateUniqueId(),
                        title: _title,
                        type: HabitType.task,
                        category: "task",
                        createdAt: DateTime.now());
                    HabitServices.createHabit(task: newHabit);
                    _backToHome(context);
                  } else {
                    print("Please fill out the task");
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ));
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(20),
          title: Text(
            'Select a category',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.all(0),
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(color: Colors.grey))),
            child: CategoryGrid(
              onCategorySelected: (String category) {
                setState(() {
                  _selectedCategory = category;
                });
                Navigator.pop(context);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          actionsPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        );
      },
    );
  }
}
