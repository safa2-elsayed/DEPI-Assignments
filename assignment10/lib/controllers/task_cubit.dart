import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit()
    : super(
        TaskState(
          draftDate: DateTime.now(),
          tasks: [
            Task(
              id: '1',
              title: 'Clean my room ',
              date: DateTime.now(),
              category: 'Personal',
              isCompleted: false,
            ),
            Task(
              id: '2',
              title: 'Submit my essay',
              date: DateTime.now(),
              category: 'Learning',
              isCompleted: false,
            ),
            Task(
              id: '3',
              title: 'Shopping',
              date: DateTime.now().subtract(const Duration(days: 1)),
              category: 'Family',
              isCompleted: true,
            ),
          ],
        ),
      );

  void changeTab(int index) {
    emit(state.copyWith(currentTab: index));
  }

  List<Task> get filteredTasks {
    if (state.currentTab == 1)
      return state.tasks.where((t) => !t.isCompleted).toList();
    if (state.currentTab == 2)
      return state.tasks.where((t) => t.isCompleted).toList();
    return state.tasks;
  }

  void toggleTaskStatus(String id) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));
  }

  void updateDraftDate(DateTime date) {
    emit(state.copyWith(draftDate: date));
  }

  void updateDraftCategory(String category) {
    emit(state.copyWith(draftCategory: category));
  }

  void addTask(String title) {
    if (state.draftCategory == null) return;

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      date: state.draftDate,
      category: state.draftCategory!,
    );

    final updatedTasks = List<Task>.from(state.tasks)..add(newTask);

    emit(
      state.copyWith(
        tasks: updatedTasks,
        draftDate: DateTime.now(),
        draftCategory: null,
      ),
    );
  }
}
