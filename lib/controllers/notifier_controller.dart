import 'package:flutter/material.dart';
import 'package:testing/controllers/app_bar_notifier.dart';
import 'package:testing/controllers/task_notifier.dart';
import 'package:testing/controllers/title_notifier.dart';

class NotifierController extends StatefulWidget {
  final Widget child;

  const NotifierController({super.key, required this.child});

  static NotifierControllerData of(BuildContext context) {
    var data = context.dependOnInheritedWidgetOfExactType<_InheritedNotifierController>();
    assert(data != null, 'Леее куда преш не видиш NotifierControllerData в дереве виджетов нет');
    return data!.data;
  }

  @override
  State<NotifierController> createState() => NotifierControllerData();
}

class NotifierControllerData extends State<NotifierController> {
  late TaskNotifier taskNotifier = TaskNotifier();
  late AppBarNotifier appBarNotifier = AppBarNotifier();
  late TitleNotifier titleNotifier = TitleNotifier();

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierController(data: this, child: widget.child);
  }
}

class _InheritedNotifierController extends InheritedWidget {
  const _InheritedNotifierController({required this.data, required super.child});

  final NotifierControllerData data;

  @override
  bool updateShouldNotify(_InheritedNotifierController oldWidget) => true;
}
