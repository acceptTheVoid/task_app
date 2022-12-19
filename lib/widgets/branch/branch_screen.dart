import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/widgets/branch/branch_app_bar.dart';
import 'package:task_app/widgets/branch/empty_body.dart';
import 'dialog/create_task.dart';
import 'list_item.dart';

class BranchScreen extends StatelessWidget {
  const BranchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();

    return Scaffold(
      appBar: BranchAppBar(),
      body: taskState.tasks.isEmpty ? const EmptyBody() : _createList(context, taskState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _floatingActionButtonPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createList(BuildContext context, TaskState taskState) {
    final list = taskState.tasks;

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final task = list[index];

        return ListItem(task: task);
      },
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
