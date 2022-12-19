import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/widgets/branch/branch_app_bar.dart';
import '../branch/branch_body.dart';
import 'dialog/create_task.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BranchAppBar(),
      body: const BranchBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _floatingActionButtonPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _floatingActionButtonPressed() async {
    final taskState = Provider.of<TaskState>(context, listen: false);

    final String? newTask = await showDialog(
      context: context,
      builder: (_) => const TaskCreationDialog(),
    );

    if (newTask != null) {
      taskState.addTask(newTask);
    }
  }
}
