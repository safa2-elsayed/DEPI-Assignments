import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit()
      : super(
          TaskState(
            draftDate: DateTime.now(),
            tasks: [], 
          ),
        ) {
    _loadTasks();
  }

  static const String _tasksKey = 'cached_tasks';

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksStringList = prefs.getStringList(_tasksKey) ?? [];
    
    final tasks = tasksStringList
        .map((taskStr) => Task.fromJson(jsonDecode(taskStr)))
        .toList();
        
    emit(state.copyWith(tasks: tasks));
  }

 
  Future<void> _saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksStringList = tasks
        .map((task) => jsonEncode(task.toJson()))
        .toList();
        
    await prefs.setStringList(_tasksKey, tasksStringList);
  }

  void changeTab(int index) {
    emit(state.copyWith(currentTab: index));
  }

  List<Task> get filteredTasks {
    if (state.currentTab == 1) {
      return state.tasks.where((t) => !t.isCompleted).toList();
    }
    if (state.currentTab == 2) {
      return state.tasks.where((t) => t.isCompleted).toList();
    }
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
    _saveTasks(updatedTasks); 
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
    _saveTasks(updatedTasks); 
  }
}