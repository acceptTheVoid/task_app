import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controllers/title_state.dart';
import 'package:task_app/widgets/branch/dialog/cancel_button.dart';
import 'package:task_app/widgets/branch/dialog/redact_branch.dart';

import '../../controllers/task_state.dart';

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

    Icon checkIcon, favouriteIcon;
    String checkTitle, favouriteTitle;
    if (taskState.showOnlyCompleted) {
      checkIcon = const Icon(Icons.check_circle_outline);
      checkTitle = 'Показать выполненные';
    } else {
      checkIcon = const Icon(Icons.check_circle);
      checkTitle = 'Скрыть выполненные';
    }

    if (taskState.showOnlyFavorite) {
      favouriteIcon = const Icon(Icons.star_border);
      favouriteTitle = 'Показать все';
    } else {
      favouriteIcon = const Icon(Icons.star);
      favouriteTitle = 'Только избранные';
    }

    final options = [
      _createMenuItem(checkTitle, () => taskState.toggleOnlyCompleted(), checkIcon),
      _createMenuItem(favouriteTitle, () => setState(() => taskState.toggleOnlyFavorite()), favouriteIcon),
      _createMenuItem('Сортировать', null, const Icon(Icons.sort)),
      _createMenuItem(
        'Удалить выполненные',
        // Костыль с Future.delayed нужен потому что внутри PopupMenuItem (который эта функция и возвращает)
        // Вызывается Navigator.pop и сразу же удаляет диалоговое окно
        () => Future.delayed(Duration.zero, _showDeleteDialogue),
        const Icon(Icons.delete_outline),
      ),
      _createMenuItem('Выбрать тему', null, const Icon(Icons.style_outlined)),
      _createMenuItem(
        'Редактировать ветку',
        // Костыль с Future.delayed нужен потому что внутри PopupMenuItem (который эта функция и возвращает)
        // Вызывается Navigator.pop и сразу же удаляет диалоговое окно
        () => Future.delayed(Duration.zero, _onPressed),
        const Icon(Icons.mode_edit_outlined),
      ),
    ];

    return AppBar(
      title: Text(titleState.title),
      actions: [PopupMenuButton(itemBuilder: (_) => options)],
    );
  }

  void _onPressed() async {
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

  PopupMenuItem _createMenuItem(String title, void Function()? onTap, Icon icon) {
    return PopupMenuItem(
      onTap: onTap,
      child: ListTile(
        leading: icon,
        title: Text(title),
      ),
    );
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
