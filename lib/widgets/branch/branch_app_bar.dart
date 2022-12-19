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

    return AppBar(
      title: Text(titleState.title),
      actions: [
        PopupMenuButton(
          itemBuilder: (_) => [
            _buildToggleOnlyCompleted(),
            _buildToggleOnlyFavorite(),
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
          ],
        ),
      ],
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

  PopupMenuItem _buildToggleOnlyCompleted() {
    final taskState = Provider.of<TaskState>(context, listen: false);

    if (taskState.showOnlyCompleted) {
      return _createMenuItem(
        icon: const Icon(Icons.check_circle_outline),
        title: 'Показать выполненные',
        onTap: taskState.toggleOnlyCompleted,
      );
    } else {
      return _createMenuItem(
        icon: const Icon(Icons.check_circle),
        title: 'Скрыть выполненные',
        onTap: taskState.toggleOnlyCompleted,
      );
    }
  }

  PopupMenuItem _buildToggleOnlyFavorite() {
    final taskState = Provider.of<TaskState>(context, listen: false);

    if (taskState.showOnlyFavorite) {
      return _createMenuItem(
        icon: const Icon(Icons.star_border),
        title: 'Показать все',
        onTap: taskState.toggleOnlyFavorite,
      );
    } else {
      return _createMenuItem(
        icon: const Icon(Icons.star),
        title: 'Показать избранные',
        onTap: taskState.toggleOnlyFavorite,
      );
    }
  }

  void _setNewTitle() async {
    final titleState = context.read<TitleState>();

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
