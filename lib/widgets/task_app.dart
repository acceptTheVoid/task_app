import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/controllers/title_state.dart';

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
        iconTheme: IconThemeData(color: theme[400]),
        floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: theme[400]),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<TaskState>(create: (_) => TaskState()),
          ChangeNotifierProvider<TitleState>(create: (_) => TitleState()),
        ],
        child: const BranchScreen(),
      ),
    );
  }
}
