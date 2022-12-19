import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

class TaskState extends ChangeNotifier {
  bool _showOnlyCompleted = false;
  bool _showOnlyFavorite = false;

  final Uuid _uuidGenerator = const Uuid();

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
    Iterable<Task> shownTasksIterable = _tasks;
    if (_showOnlyFavorite) {
      shownTasksIterable = shownTasksIterable.where((task) => task.isFavorite);
    }

    if (_showOnlyCompleted) {
      shownTasksIterable = shownTasksIterable.where((task) => !task.isCompleted);
    }

    _filteredTasks = shownTasksIterable.toList();

    notifyListeners();
  }

  void addTask(String title) {
    _tasks.add(Task(id: _uuidGenerator.v4(), title: title));
    _filterTasks();
  }

  void changeCheckWithId(String id) {
    final idx = _tasks.indexWhere((task) => task.id == id);
    final task = _tasks[idx];
    _tasks[idx] = task.copyWith(isCompleted: !task.isCompleted);
    _filterTasks();
  }

  void changeFavWithId(String id) {
    final idx = _tasks.indexWhere((task) => task.id == id);
    final task = _tasks[idx];
    _tasks[idx] = task.copyWith(isFavorite: !task.isFavorite);
    _filterTasks();
  }

  void removeTaskWithId(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _filterTasks();
  }

  void removeAllChecked() {
    _tasks.removeWhere((task) => task.isCompleted);
    _filterTasks();
  }
}
