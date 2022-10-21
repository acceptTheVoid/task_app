import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/state_provider.dart';
import '../../models/task.dart';

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
          return _createEmptyBody(context);
        }

        return _createList(context);
      },
    );
  }

  Widget _createEmptyBody(BuildContext context) {
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
    final stateProvider = StateProvider.of(context);
    final taskState = stateProvider.taskState;
    final appBarState = stateProvider.appBarState;
    final themeColor = Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: taskState,
      builder: (context, child) {
        final list = taskState.tasks;

        final List<Task> viewedList = [];
        final List<int> origIdx = [];
        for (int i = 0; i != list.length; ++i) {
          if (!(appBarState.showOnlyChecked && list[i].isChecked || appBarState.showOnlyFavorite && !list[i].isFav)) {
            viewedList.add(list[i]);
            origIdx.add(i);
          }
        }

        return ListView.builder(
          itemCount: viewedList.length,
          itemBuilder: (ctx, idx) {
            var task = viewedList[idx];

            var listItem = ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  leading: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      onChanged: (_) => taskState.changeCheckAt(origIdx[idx]),
                      activeColor: themeColor,
                      value: task.isChecked,
                    ),
                  ),
                  title: Text(task.title),
                  trailing: IconButton(
                    onPressed: () => taskState.changeFavAt(origIdx[idx]),
                    icon: Transform.scale(scale: 1.5, child: Icon(task.isFav ? Icons.star_sharp : Icons.star_outline)),
                    color: (task.isFav ? Colors.amber : Colors.black54),
                  ),
                ),
              ),
            );

            return Dismissible(
              key: ObjectKey(task),
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
              onDismissed: (direction) => taskState.removeTaskAt(origIdx[idx]),
              child: listItem,
            );
          },
        );
      },
    );
  }
}
