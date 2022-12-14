import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/models/task.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).primaryColor;
    final taskState = context.read<TaskState>();

    final listItem = ClipRRect(
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
      onDismissed: (_) => taskState.removeTaskWithId(task.id),
      child: listItem,
    );
  }
}
