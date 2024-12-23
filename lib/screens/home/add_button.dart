import 'package:flutter/material.dart';
import 'package:remindme/screens/add_diary/add_diary_page.dart';
import 'package:remindme/screens/add_habit/add_habit_page.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.task_alt, color: Colors.blue),
                    title: const Text('Task'),
                    subtitle: const Text('Add a new task to your list'),
                    onTap: () {
                      _navigateTo(
                          context,
                          AddHabitPage(
                            habitCategory: "Task",
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.loop, color: Colors.green),
                    title: const Text('Habit'),
                    subtitle: const Text('Track your new habit'),
                    onTap: () {
                      _navigateTo(
                          context,
                          AddHabitPage(
                            habitCategory: "Habit",
                          ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book, color: Colors.purple),
                    title: const Text('Diary'),
                    subtitle: const Text('Write a new diary entry'),
                    onTap: () {
                      _navigateTo(context, AddDiaryPage());
                    },
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.emoji_events, color: Colors.orange),
                    title: const Text('Challenge'),
                    subtitle: const Text('Challenge yourself to be better'),
                    onTap: () {
                      Navigator.pop(context, 'challenge');
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
