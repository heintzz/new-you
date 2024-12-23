import 'package:flutter/material.dart';
import 'package:remindme/model/habit_model.dart';

class HabitList extends StatelessWidget {
  final List<HabitTask> tasks;
  final Function(HabitTask task) onStatusChange;

  const HabitList({
    super.key,
    required this.tasks,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...tasks.map((task) => HabitCard(
            task: task,
            onStatusChange: onStatusChange,
          ))
    ]);
  }
}

class HabitCard extends StatelessWidget {
  final HabitTask task;
  final Function(HabitTask task) onStatusChange;

  const HabitCard({
    super.key,
    required this.task,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListTile(
        leading: Icon(Icons.category),
        title: Text(task.title),
        subtitle: Text(task.type.name),
        trailing: CircleAvatar(
          backgroundColor: getCompletionColor(task.completionId),
          radius: 20,
          child: InkWell(
            onTap: () {
              onStatusChange(task);
            },
            borderRadius: BorderRadius.circular(20),
            child: getCompletionIcon(task.completionId),
          ),
        ),
      ),
    );
  }
}
