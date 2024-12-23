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
  final DateTime createdAt;
  final String? parentId;
  CompletionType completionId;

  HabitTask(
      {required this.id,
      required this.title,
      required this.type,
      required this.createdAt,
      this.parentId,
      this.completionId = CompletionType.pending});
}
