import 'package:flutter/material.dart';
import '/controllers/app_bar_state.dart';
import '/controllers/task_state.dart';
import '/controllers/title_state.dart';

class StateProvider extends StatefulWidget {
  final Widget child;

  const StateProvider({super.key, required this.child});

  static StateProviderData of(BuildContext context) {
    var data = context.dependOnInheritedWidgetOfExactType<_InheritedStateProvider>();
    assert(data != null, 'Леее куда преш не видиш NotifierController в дереве виджетов нет');
    return data!.data;
  }

  @override
  State<StateProvider> createState() => StateProviderData();
}

class StateProviderData extends State<StateProvider> {
  late final TaskState taskState;
  late final AppBarState appBarState;
  late final TitleState titleState;

  @override
  void initState() {
    appBarState = AppBarState();
    taskState = TaskState();
    titleState = TitleState();
    super.initState();
  }

  @override
  void dispose() {
    appBarState.dispose();
    taskState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateProvider(data: this, child: widget.child);
  }
}

class _InheritedStateProvider extends InheritedWidget {
  const _InheritedStateProvider({required this.data, required super.child});

  final StateProviderData data;

  @override
  bool updateShouldNotify(_InheritedStateProvider oldWidget) {
    return data.titleState != oldWidget.data.titleState ||
        data.appBarState != oldWidget.data.appBarState ||
        data.taskState != oldWidget.data.taskState;
  }
}
