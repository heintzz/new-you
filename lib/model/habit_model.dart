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

enum CompletionType { pending, done, skip }

CompletionType getNextStatus(CompletionType currentStatus) {
  switch (currentStatus) {
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
  CompletionType completionId;
  final HabitType type;
  final DateTime createdAt;

  HabitTask(
      {required this.id,
      required this.title,
      required this.type,
      this.completionId = CompletionType.pending,
      required this.createdAt});
}
