import 'dart:collection';
import '../models/task.dart';

class TaskState {
  final List<Task> _tasks = [
    Task(title: 'Илья Обухов'),
    Task(title: 'Флаттер для...'),
    Task(title: 'Таска'),
  ];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void addTask(String title) {
    _tasks.add(Task(title: title));
  }

  void changeCheckAt(int idx) {
    _tasks[idx].isChecked = !_tasks[idx].isChecked;
  }

  void changeFavAt(int idx) {
    _tasks[idx].isFav = !_tasks[idx].isFav;
  }

  void removeTaskAt(int idx) {
    _tasks.removeAt(idx);
  }

  void removeAllChecked() {
    _tasks.removeWhere((task) => task.isChecked);
  }
}
