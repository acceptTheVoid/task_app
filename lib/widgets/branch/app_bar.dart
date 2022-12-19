import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/title_state.dart';
import 'package:task_app/widgets/branch/dialog/cancel_button.dart';
import 'package:task_app/widgets/branch/dialog/redact_branch.dart';

import '/controllers/task_state.dart';

class BranchAppBar extends AppBar {
  BranchAppBar({super.key});

  @override
  State<BranchAppBar> createState() => _BranchAppBarState();
}

class _BranchAppBarState extends State<BranchAppBar> {
  @override
  Widget build(BuildContext context) {
    final titleState = context.watch<TitleState>();
    final taskState = context.watch<TaskState>();

    late PopupMenuItem showOnlyCompleted;
    if (taskState.showOnlyCompleted) {
      showOnlyCompleted = _createMenuItem(
        icon: const Icon(Icons.check_circle_outline),
        title: 'Показать выполненные',
        onTap: taskState.toggleOnlyCompleted,
      );
    } else {
      showOnlyCompleted = _createMenuItem(
        icon: const Icon(Icons.check_circle),
        title: 'Скрыть выполненные',
        onTap: taskState.toggleOnlyCompleted,
      );
    }

    late PopupMenuItem showOnlyFavorite;
    if (taskState.showOnlyFavorite) {
      showOnlyFavorite = _createMenuItem(
        icon: const Icon(Icons.star_border),
        title: 'Показать все',
        onTap: taskState.toggleOnlyFavorite,
      );
    } else {
      showOnlyFavorite = showOnlyFavorite = _createMenuItem(
        icon: const Icon(Icons.star),
        title: 'Показать избранные',
        onTap: taskState.toggleOnlyFavorite,
      );
    }

    final options = [
      showOnlyCompleted,
      showOnlyFavorite,
      _createMenuItem(title: 'Сортировать', icon: const Icon(Icons.sort)),
      _createMenuItem(
        title: 'Удалить выполненные',
        icon: const Icon(Icons.delete_outline),
        onTap: () => _wrapShowDialog(_showDeleteDialogue),
      ),
      _createMenuItem(title: 'Выбрать тему', icon: const Icon(Icons.style_outlined)),
      _createMenuItem(
        title: 'Редактировать ветку',
        icon: const Icon(Icons.mode_edit_outlined),
        onTap: () => _wrapShowDialog(_setNewTitle),
      ),
    ];

    return AppBar(
      title: Text(titleState.title),
      actions: [PopupMenuButton(itemBuilder: (_) => options)],
    );
  }

  PopupMenuItem _createMenuItem({required String title, void Function()? onTap, required Icon icon}) {
    return PopupMenuItem(
      onTap: onTap,
      child: ListTile(
        leading: icon,
        title: Text(title),
      ),
    );
  }

  void _setNewTitle() async {
    final titleState = Provider.of<TitleState>(context, listen: false);

    final String? newTitle = await showDialog(
      context: context,
      builder: (_) => RedactBranchDialog(
        currentTitle: titleState.title,
      ),
    );

    if (newTitle != null) {
      titleState.setTitle(newTitle);
    }
  }

  void _wrapShowDialog(void Function() callback) async {
    // Костыль с Future.delayed нужен потому что внутри PopupMenuItem (который эта функция и возвращает)
    // Вызывается Navigator.pop и сразу же удаляет диалоговое окно
    return Future.delayed(Duration.zero, callback);
  }

  Future<void> _showDeleteDialogue() {
    final taskState = Provider.of<TaskState>(context, listen: false);

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтвердите удаление'),
          content: const Text('Удалить выбранные задачи? Это действительно необратимо'),
          actions: [
            const CancelButton(),
            TextButton(
              onPressed: () {
                taskState.removeAllChecked();
                Navigator.pop(context);
              },
              child: const Text('Подтвердить'),
            )
          ],
        );
      },
    );
  }
}
