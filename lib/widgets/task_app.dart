import 'package:flutter/material.dart';
import '/controllers/notifier_controller.dart';

import 'branch.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Colors.green;

    var branch = const Branch();
    var homeData = NotifierController(child: branch);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: theme[400],
        appBarTheme: AppBarTheme(color: theme[400]),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: theme[400]),
      ),
      home: homeData,
    );
  }
}
