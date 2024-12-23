import 'package:flutter/material.dart';

enum HabitType {
  habit,
  task;

  String get name {
    switch (this) {
      case HabitType.habit:
        return 'Habit';
      case HabitType.task:
        return 'Task';
    }
  }
}

enum CompletionType { lock, pending, done, skip }

CompletionType getNextStatus(CompletionType currentStatus) {
  switch (currentStatus) {
    case CompletionType.lock:
      return CompletionType.lock;
    case CompletionType.pending:
      return CompletionType.done;
    case CompletionType.done:
      return CompletionType.skip;
    case CompletionType.skip:
      return CompletionType.pending;
  }
}

class HabitTask {
  final String id;
  final String title;
  final HabitType type;
  final String category;
  final DateTime createdAt;
  final String? parentId;
  CompletionType completionId;

  HabitTask(
      {required this.id,
      required this.title,
      required this.type,
      required this.category,
      required this.createdAt,
      this.parentId,
      this.completionId = CompletionType.pending});
}

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

String generateUniqueId() {
  return DateTime.now().microsecondsSinceEpoch.toString();
}
