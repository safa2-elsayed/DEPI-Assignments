import '../models/task_model.dart';

class TaskState {
  final List<Task> tasks;
  final int currentTab;

  final DateTime draftDate;
  final String? draftCategory;

  TaskState({
    required this.tasks,
    this.currentTab = 0,
    required this.draftDate,
    this.draftCategory,
  });

  TaskState copyWith({
    List<Task>? tasks,
    int? currentTab,
    DateTime? draftDate,
    String? draftCategory,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      currentTab: currentTab ?? this.currentTab,
      draftDate: draftDate ?? this.draftDate,
      draftCategory: draftCategory ?? this.draftCategory,
    );
  }
}
