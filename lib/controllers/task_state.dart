import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:task_app/controllers/task_filters_state.dart';

import '../models/task.dart';

class TaskState extends ChangeNotifier {
  int _taskCounter = 0;

  final TaskFiltersState appBarState;

  final List<Task> _tasks = [];
  List<Task> _viewedTasks = [];

  TaskState({required this.appBarState}) {
    addTask('Илья Обухов');
    addTask('Флаттер для...');
    addTask('Таска');
    appBarState.addListener(_filterTasks);
  }

  @override
  void dispose() {
    appBarState.removeListener(_filterTasks);
    super.dispose();
  }

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_viewedTasks);

  void _filterTasks() {
    final List<Task> viewedList = [];
    for (int i = 0; i != _tasks.length; ++i) {
      if (!(appBarState.showOnlyCompleted && _tasks[i].isChecked ||
          appBarState.showOnlyFavorite && !_tasks[i].isFavorite)) {
        viewedList.add(_tasks[i]);
      }
    }

    _viewedTasks = viewedList;
    notifyListeners();
  }

  void addTask(String title) {
    _tasks.add(Task(id: _taskCounter++, title: title));
    _filterTasks();
  }

  void changeCheckAt(int idx) {
    final task = _tasks.lastWhere((task) => task.id == idx);
    task.isChecked = !task.isChecked;
    _filterTasks();
  }

  void changeFavAt(int idx) {
    final task = _tasks.lastWhere((task) => task.id == idx);
    task.isFavorite = !task.isFavorite;
    _filterTasks();
  }

  void removeTaskAt(int idx) {
    _tasks.removeWhere((task) => task.id == idx);
    _filterTasks();
  }

  void removeAllChecked() {
    _tasks.removeWhere((task) => task.isChecked);
    _filterTasks();
  }
}
