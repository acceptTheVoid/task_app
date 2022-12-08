import 'package:flutter/material.dart';
import '/controllers/app_bar_state.dart';
import '/controllers/task_state.dart';
import '/controllers/title_state.dart';

class StateProvider extends StatefulWidget {
  final Widget child;

  const StateProvider({super.key, required this.child});

  static StateDataProvider of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<_InheritedStateProvider>();
    assert(provider != null, 'Леее куда преш не видиш NotifierController в дереве виджетов нет');
    return provider!.data;
  }

  @override
  State<StateProvider> createState() => StateDataProvider();
}

class StateDataProvider extends State<StateProvider> {
  late final TaskState taskState;
  late final AppBarState appBarState;
  late final TitleState titleState;

  @override
  void initState() {
    super.initState();

    appBarState = AppBarState();
    taskState = TaskState(appBarState: appBarState);
    titleState = TitleState();
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

  final StateDataProvider data;

  @override
  bool updateShouldNotify(_InheritedStateProvider oldWidget) {
    return data.titleState != oldWidget.data.titleState ||
        data.appBarState != oldWidget.data.appBarState ||
        data.taskState != oldWidget.data.taskState;
  }
}
