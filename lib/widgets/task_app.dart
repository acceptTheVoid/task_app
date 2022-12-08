import 'package:flutter/material.dart';
import '/controllers/state_provider.dart';

import 'branch/branch.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    const theme = Colors.green;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: theme[400],
        appBarTheme: AppBarTheme(color: theme[400]),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: theme[400]),
      ),
      home: StateProvider(child: Branch()),
    );
  }
}
