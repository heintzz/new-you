import 'package:flutter/material.dart';
import 'package:remindme/model/habit_model.dart';

final List<HabitTask> dummyHabitTasks = [
  HabitTask(
      id: '1',
      title: 'Morning Exercise',
      completionId: CompletionType.done,
      type: HabitType.habit,
      createdAt: DateTime.now()),
  HabitTask(
    id: '2',
    title: 'Read Books',
    completionId: CompletionType.pending,
    type: HabitType.habit,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
  // HabitTask(
  //     id: '3',
  //     title: 'Submit Assignment',
  //     completionId: CompletionType.skip,
  //     type: HabitType.task,
  //     createdAt: DateTime.now().subtract(Duration(days: 1))),
  // HabitTask(
  //     id: '4',
  //     title: 'Meditate',
  //     completionId: CompletionType.pending,
  //     type: HabitType.habit,
  //     createdAt: DateTime.now()),
  // HabitTask(
  //     id: '5',
  //     title: 'Call Mom',
  //     completionId: CompletionType.done,
  //     type: HabitType.task,
  //     createdAt: DateTime.now()),
];

Color getCompletionColor(CompletionType status) {
  switch (status) {
    case CompletionType.done:
      return Colors.green[100]!;
    case CompletionType.skip:
      return Colors.red[100]!;
    case CompletionType.lock:
      return Colors.grey[300]!;
    case CompletionType.pending:
      return Colors.grey[300]!;
  }
}

Widget getCompletionIcon(CompletionType status) {
  switch (status) {
    case CompletionType.done:
      return Icon(Icons.check, color: Colors.green);
    case CompletionType.skip:
      return Icon(Icons.close, color: Colors.red);
    case CompletionType.lock:
      return Icon(Icons.lock, color: Colors.grey[400]);
    case CompletionType.pending:
      return Container();
  }
}
