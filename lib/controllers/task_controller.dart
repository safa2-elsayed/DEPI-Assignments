import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskController extends ChangeNotifier {
  final List<Task> _tasks = [
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
  ];

  int _currentTab = 0;

  int get currentTab => _currentTab;

  List<Task> get filteredTasks {
    if (_currentTab == 1) return _tasks.where((t) => !t.isCompleted).toList();
    if (_currentTab == 2) return _tasks.where((t) => t.isCompleted).toList();
    return _tasks;
  }

  void changeTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  void addTask(String title, DateTime date, String category) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      date: date,
      category: category,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      notifyListeners();
    }
  }
}
