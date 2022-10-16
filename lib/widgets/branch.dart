import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/controllers/notifier_controller.dart';
import 'package:testing/models/task.dart';

class Branch extends StatefulWidget {
  const Branch({super.key});

  @override
  State<Branch> createState() => _BranchState();
}

class _BranchState extends State<Branch> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var taskNotifier = NotifierController.of(context).taskNotifier;

    onPressed() {
      showDialog(
        context: context,
        builder: (context) {
          final textController = TextEditingController();
          return AlertDialog(
            title: const Text('Создать задачу'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Введите название задачи'),
                maxLength: 40,
                validator: _validator,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              _createCancelButton(context),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      taskNotifier.addTask(textController.text);
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Создать!'),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: _createAppBar(),
      body: _createList(),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _createList() {
    var themeColor = Theme.of(context).primaryColor;
    var nc = NotifierController.of(context);
    var taskNotifier = nc.taskNotifier;
    var appBarNotifier = nc.appBarNotifier;
    var list = taskNotifier.tasks;

    List<Task> viewedList = [];
    List<int> origIdx = [];
    for (int i = 0; i != list.length; ++i) {
      if (!(appBarNotifier.isUnchecked && list[i].isChecked || appBarNotifier.isOnlyFav && !list[i].isFav)) {
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
                  onChanged: (_) => setState(() {
                    taskNotifier.changeCheckAt(origIdx[idx]);
                  }),
                  activeColor: themeColor,
                  value: task.isChecked,
                ),
              ),
              title: Text(task.title),
              trailing: IconButton(
                onPressed: () => setState(() {
                  taskNotifier.changeFavAt(origIdx[idx]);
                }),
                icon: Transform.scale(scale: 1.5, child: Icon(task.isFav ? Icons.star_sharp : Icons.star_outline)),
                color: (task.isFav ? Colors.amber : Colors.black54),
              ),
            ),
          ),
        );

        return Dismissible(
          key: ObjectKey(task),
          background: Container(
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) => setState(() {
            taskNotifier.removeTaskAt(origIdx[idx]);
          }),
          child: listItem,
        );
      },
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Текст введи...';
    }

    if (value.length > 40) {
      return 'Текст убери...';
    }

    return null;
  }

  AppBar _createAppBar() {
    var notifier = NotifierController.of(context).appBarNotifier;
    var taskNotifier = NotifierController.of(context).taskNotifier;
    var titleNotifier = NotifierController.of(context).titleNotifier;
    var theme = Theme.of(context).primaryColor;
    Icon checkIcon, favouriteIcon;
    String checkTitle, favouriteTitle;
    if (notifier.isUnchecked) {
      checkIcon = Icon(Icons.check_circle_outline, color: theme);
      checkTitle = 'Показать выполненные';
    } else {
      checkIcon = Icon(Icons.check_circle, color: theme);
      checkTitle = 'Скрыть выполненные';
    }

    if (notifier.isOnlyFav) {
      favouriteIcon = Icon(Icons.star_border, color: theme);
      favouriteTitle = 'Показать все';
    } else {
      favouriteIcon = Icon(Icons.star, color: theme);
      favouriteTitle = 'Только избранные';
    }

    var options = [
      _createMenuItem(checkTitle, () => setState(() => notifier.setUnchecked()), checkIcon),
      _createMenuItem(favouriteTitle, () => setState(() => notifier.setOnlyFav()), favouriteIcon),
      _createMenuItem('Сортировать', null, Icon(Icons.sort, color: theme)),
      _createMenuItem(
        'Удалить выполненные',
        () {
          Future.delayed(
            const Duration(seconds: 0),
            () => showDialog(
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
                          taskNotifier.removeAllChecked();
                          setState(() {});
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Подтвердить'),
                    )
                  ],
                );
              },
            ),
          );
        },
        Icon(Icons.delete_outline, color: theme),
      ),
      _createMenuItem('Выбрать тему', null, Icon(Icons.style_outlined, color: theme)),
      _createMenuItem(
        'Редактировать ветку',
        () {
          Future.delayed(
            const Duration(seconds: 0),
            () => showDialog(
              context: context,
              builder: (BuildContext context) {
                final textController = TextEditingController();
                textController.text = titleNotifier.title;

                return AlertDialog(
                  title: const Text("Редактировать ветку"),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: textController,
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
                            titleNotifier.setTitle(textController.text);
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: const Text("Ок"),
                    )
                  ],
                );
              },
            ),
          );
        },
        Icon(Icons.mode_edit_outlined, color: theme),
      ),
    ];

    return AppBar(
      title: Text(NotifierController.of(context).titleNotifier.title),
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
}
