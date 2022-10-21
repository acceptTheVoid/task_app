import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_app/controllers/app_bar_state.dart';
import 'package:task_app/controllers/state_provider.dart';
import 'package:task_app/controllers/title_state.dart';

import '../../controllers/task_state.dart';

class BranchAppBar extends AppBar {
  BranchAppBar({super.key});

  @override
  State<BranchAppBar> createState() => _BranchAppBarState();
}

class _BranchAppBarState extends State<BranchAppBar> {
  late final AppBarState appBarState;
  late final TaskState taskState;
  late final TitleState titleState;
  late final Color themeColor;

  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    final provider = StateProvider.of(context);

    appBarState = provider.appBarState;
    taskState = provider.taskState;
    titleState = provider.titleState;

    themeColor = Theme.of(context).primaryColor;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Icon checkIcon, favouriteIcon;
    String checkTitle, favouriteTitle;
    if (appBarState.showOnlyChecked) {
      checkIcon = Icon(Icons.check_circle_outline, color: themeColor);
      checkTitle = 'Показать выполненные';
    } else {
      checkIcon = Icon(Icons.check_circle, color: themeColor);
      checkTitle = 'Скрыть выполненные';
    }

    if (appBarState.showOnlyFavorite) {
      favouriteIcon = Icon(Icons.star_border, color: themeColor);
      favouriteTitle = 'Показать все';
    } else {
      favouriteIcon = Icon(Icons.star, color: themeColor);
      favouriteTitle = 'Только избранные';
    }

    final options = [
      _createMenuItem(checkTitle, () => setState(() => appBarState.toggleOnlyChecked()), checkIcon),
      _createMenuItem(favouriteTitle, () => setState(() => appBarState.toggleOnlyFavorite()), favouriteIcon),
      _createMenuItem('Сортировать', null, Icon(Icons.sort, color: themeColor)),
      _createMenuItem(
        'Удалить выполненные',
        // Костыль с Future.delayed нужен потому что внутри PopupMenuItem (который эта функция и возвращает)
        // Вызывается Navigator.pop и сразу же удаляет диалоговое окно
        () => Future.delayed(const Duration(seconds: 0), () => _showDeleteDialogue()),
        Icon(Icons.delete_outline, color: themeColor),
      ),
      _createMenuItem('Выбрать тему', null, Icon(Icons.style_outlined, color: themeColor)),
      _createMenuItem(
        'Редактировать ветку',
        // Костыль с Future.delayed нужен потому что внутри PopupMenuItem (который эта функция и возвращает)
        // Вызывается Navigator.pop и сразу же удаляет диалоговое окно
        () => Future.delayed(const Duration(seconds: 0), () => _showRedactBranchDialogue()),
        Icon(Icons.mode_edit_outlined, color: themeColor),
      ),
    ];

    return AppBar(
      title: Text(titleState.title),
      actions: [PopupMenuButton(itemBuilder: (_) => options)],
    );
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

  TextButton _createCancelButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Отмена"),
    );
  }

  Future<void> _showDeleteDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Подтвердите удаление'),
          content: const Text('Удалить выбранные задачи? Это действительно необратимо'),
          actions: [
            _createCancelButton(context),
            TextButton(
              onPressed: () {
                Future.delayed(const Duration(seconds: 0), () {
                  taskState.removeAllChecked();
                  setState(() {});
                });
                Navigator.pop(context);
              },
              child: const Text('Подтвердить'),
            )
          ],
        );
      },
    );
  }

  Future<void> _showRedactBranchDialogue() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        _textController.text = titleState.title;

        final dialogue = AlertDialog(
          title: const Text("Редактировать ветку"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: "Введите название ветки",
              ),
              maxLength: 40,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              validator: _validator,
            ),
          ),
          actions: [
            _createCancelButton(context),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    titleState.setTitle(_textController.text);
                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text("Ок"),
            )
          ],
        );

        return dialogue;
      },
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Название не может быть пустым';
    }

    if (value.length > 40) {
      return 'Слишком длинное название';
    }

    return null;
  }
}
