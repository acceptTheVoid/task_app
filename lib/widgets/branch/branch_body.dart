import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/assets_paths.dart';
import 'package:task_app/widgets/branch/list_item.dart';

class BranchBody extends StatefulWidget {
  const BranchBody({super.key});

  @override
  State<StatefulWidget> createState() => _BranchBodyState();
}

class _BranchBodyState extends State<BranchBody> {
  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();

    return taskState.tasks.isEmpty ? _createEmptyBody() : _createList(taskState);
  }

  Widget _createEmptyBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SvgPicture.asset(AssetsPaths.todoListBackground),
              SvgPicture.asset(AssetsPaths.todoList),
            ],
          ),
          const Text(
            'На данный момент задачи отсутствуют',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _createList(TaskState taskState) {
    final list = taskState.tasks;

    return Consumer<TaskState>(builder: (context, taskState, _) {
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final task = list[index];

          return ListItem(task: task);
        },
      );
    });
  }
}
