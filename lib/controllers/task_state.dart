import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskState extends ChangeNotifier {
  int _taskCounter = 0;

  bool _showOnlyCompleted = false;
  bool _showOnlyFavorite = false;

  bool get showOnlyCompleted => _showOnlyCompleted;
  bool get showOnlyFavorite => _showOnlyFavorite;

  final List<Task> _tasks = [];
  List<Task> _filteredTasks = [];

  TaskState() {
    addTask('Илья Обухов');
    addTask('Флаттер для...');
    addTask('Таска');
  }

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_filteredTasks);

  void toggleOnlyCompleted() {
    _showOnlyCompleted = !_showOnlyCompleted;
    debugPrint('Show only completed: $_showOnlyCompleted');
    _filterTasks();
  }

  void toggleOnlyFavorite() {
    _showOnlyFavorite = !_showOnlyFavorite;
    _filterTasks();
  }

  void _filterTasks() {
    _filteredTasks = [..._tasks];

    if (_showOnlyFavorite) _filteredTasks.removeWhere((task) => !task.isFavorite);
    if (_showOnlyCompleted) _filteredTasks.removeWhere((task) => task.isCompleted);

    notifyListeners();
  }

  void addTask(String title) {
    _tasks.add(Task(id: _taskCounter++, title: title));
    _filterTasks();
  }

  void changeCheckWithId(int id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    _filterTasks();
  }

  void changeFavWithId(int id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isFavorite = !task.isFavorite;
    _filterTasks();
  }

  void removeTaskWithId(int id) {
    _tasks.removeWhere((task) => task.id == id);
    _filterTasks();
  }

  void removeAllChecked() {
    _tasks.removeWhere((task) => task.isCompleted);
    _filterTasks();
  }
}
