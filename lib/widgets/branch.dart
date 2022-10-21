import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/widgets/app_bar.dart';
import '../controllers/app_bar_state.dart';
import '../controllers/task_state.dart';
import '../controllers/title_state.dart';
import '/controllers/state_provider.dart';
import '/models/task.dart';

class Branch extends StatefulWidget {
  const Branch({super.key});

  @override
  State<Branch> createState() => _BranchState();
}

class _BranchState extends State<Branch> {
  final _formKey = GlobalKey<FormState>();

  late final AppBarState appBarState;
  late final TaskState taskState;
  late final TitleState titleState;
  late final Color themeColor;

  @override
  void initState() {
    super.initState();
  }

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
  Widget build(BuildContext context) {
    onPressed() {
      showDialog(
        context: context,
        builder: (context) {
          final textController = TextEditingController();
          var dialogue = AlertDialog(
            title: const Text('Создать задачу'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Введите название задачи'),
                validator: (_) => null,
                maxLength: 40,
                maxLengthEnforcement: MaxLengthEnforcement.none,
              ),
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              _createCancelButton(context),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      taskState.addTask(textController.text);
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Создать!'),
              )
            ],
          );

          textController.dispose();
          return dialogue;
        },
      );
    }

    return Scaffold(
      appBar: BranchAppBar(),
      body: _createList(),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createList() {
    var list = taskState.tasks;

    List<Task> viewedList = [];
    List<int> origIdx = [];
    for (int i = 0; i != list.length; ++i) {
      if (!(appBarState.showOnlyChecked && list[i].isChecked || appBarState.showOnlyFavorite && !list[i].isFav)) {
        viewedList.add(list[i]);
        origIdx.add(i);
      }
    }

    if (viewedList.isEmpty) {
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
                    taskState.changeCheckAt(origIdx[idx]);
                  }),
                  activeColor: themeColor,
                  value: task.isChecked,
                ),
              ),
              title: Text(task.title),
              trailing: IconButton(
                onPressed: () => setState(() {
                  taskState.changeFavAt(origIdx[idx]);
                }),
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
          onDismissed: (direction) => setState(() {
            taskState.removeTaskAt(origIdx[idx]);
          }),
          child: listItem,
        );
      },
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
