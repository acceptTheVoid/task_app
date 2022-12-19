import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/widgets/branch/branch_app_bar.dart';
import '../branch/branch_body.dart';
import 'dialog/create_task.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BranchAppBar(),
      body: const BranchBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _floatingActionButtonPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _floatingActionButtonPressed(BuildContext context) async {
    final taskState = context.read<TaskState>();

    final newTask = await showDialog<String>(
      context: context,
      builder: (_) => const TaskCreationDialog(),
    );

    if (newTask != null) {
      taskState.addTask(newTask);
    }
  }
}
