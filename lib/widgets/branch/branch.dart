import 'package:flutter/material.dart';
import 'package:task_app/widgets/branch/app_bar.dart';
import '/controllers/state_provider.dart';
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
        onPressed: _onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPressed() async {
    final taskState = StateProvider.of(context).taskState;

    final String? res = await showDialog(
      context: context,
      builder: (context) => const TaskCreationDialog(),
    );

    if (res != null) {
      taskState.addTask(res);
    }
  }
}
