import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/task_state.dart';
import 'package:task_app/models/task_step.dart';
import 'package:task_app/widgets/branch/list_item.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final taskState = context.watch<TaskState>();
    final task = taskState.getById(id);

    final taskStepWidgets = task.taskSteps.map((e) => TaskStepView(taskId: task.id, step: e)).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(task.title),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    child: Column(
                      children: [
                        Text('Создана: ${task.timeOfCreation}'),
                        ...taskStepWidgets,
                        TextButton(
                          onPressed: () {
                            taskState.addStepById(id);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.add),
                              Text(
                                'Добавить шаг',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => taskState.changeCheckWithId(id),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskStepView extends StatelessWidget {
  const TaskStepView({super.key, required this.taskId, required this.step});

  final String taskId;
  final TaskStep step;

  @override
  Widget build(BuildContext context) {
    final taskState = context.read<TaskState>();

    return ListTile(
      leading: IconButton(
        onPressed: () {
          taskState.changeCheckInStep(taskId, step.id);
        },
        icon: Icon(step.isCompleted ? Icons.check_circle : Icons.check_circle_outline),
      ),
      title: Text(step.description),
    );
  }
}
