import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/assets_paths.dart';

class BranchBody extends StatefulWidget {
  const BranchBody({super.key});

  @override
  State<StatefulWidget> createState() => _BranchBodyState();
}

class _BranchBodyState extends State<BranchBody> {
  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();

    return taskState.tasks.isEmpty
        ? _createEmptyBody()
        : Consumer<TaskState>(
            builder: (context, taskState, _) => _createList(taskState),
          );
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
    final viewedList = taskState.tasks;

    final themeColor = Theme.of(context).primaryColor;

    return ListView.builder(
      itemCount: viewedList.length,
      itemBuilder: (context, index) {
        var task = viewedList[index];

        var listItem = ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              leading: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  shape: const CircleBorder(),
                  onChanged: (_) => taskState.changeCheckWithId(task.id),
                  activeColor: themeColor,
                  value: task.isCompleted,
                ),
              ),
              title: Text(task.title),
              trailing: IconButton(
                onPressed: () => taskState.changeFavWithId(task.id),
                icon: Transform.scale(scale: 1.5, child: Icon(task.isFavorite ? Icons.star_sharp : Icons.star_outline)),
                color: (task.isFavorite ? Colors.amber : Colors.black54),
              ),
            ),
          ),
        );

        return Dismissible(
          key: ValueKey<int>(task.id),
          direction: DismissDirection.endToStart,
          background: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          onDismissed: (direction) => taskState.removeTaskWithId(task.id),
          child: listItem,
        );
      },
    );
  }
}
