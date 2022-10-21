import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/state_provider.dart';

class BranchBody extends StatelessWidget {
  const BranchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    final taskState = stateProvider.taskState;
    final appBarState = stateProvider.appBarState;

    return AnimatedBuilder(
      animation: Listenable.merge([taskState, appBarState]),
      builder: (context, child) {
        if (taskState.tasks.isEmpty) {
          return _createEmptyBody();
        }

        return _createList(context);
      },
    );
  }

  Widget _createEmptyBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SvgPicture.asset('assets/todolist_background.svg'),
              SvgPicture.asset('assets/todolist.svg'),
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

  Widget _createList(BuildContext context) {
    final taskState = StateProvider.of(context).taskState;
    final viewedList = taskState.tasks;

    final themeColor = Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: taskState,
      builder: (context, child) {
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
                      onChanged: (_) => taskState.changeCheckAt(task.id),
                      activeColor: themeColor,
                      value: task.isChecked,
                    ),
                  ),
                  title: Text(task.title),
                  trailing: IconButton(
                    onPressed: () => taskState.changeFavAt(task.id),
                    icon: Transform.scale(
                        scale: 1.5, child: Icon(task.isFavorite ? Icons.star_sharp : Icons.star_outline)),
                    color: (task.isFavorite ? Colors.amber : Colors.black54),
                  ),
                ),
              ),
            );

            return Dismissible(
              key: ValueKey<int>(task.id),
              direction: DismissDirection.endToStart,
              background: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: const Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(top: 5, right: 5),
                    trailing: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    tileColor: Colors.red,
                  ),
                ),
              ),
              onDismissed: (direction) => taskState.removeTaskAt(task.id),
              child: listItem,
            );
          },
        );
      },
    );
  }
}
