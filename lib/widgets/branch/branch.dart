import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_app/widgets/branch/app_bar.dart';
import '/controllers/state_provider.dart';
import '../branch/branch_body.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BranchAppBar(),
      body: const BranchBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddTaskButtonPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddTaskButtonPressed(BuildContext context) {
    final stateProvider = StateProvider.of(context);
    final taskState = stateProvider.taskState;

    showDialog(
      context: context,
      builder: (context) {
        final dialog = AlertDialog(
          title: const Text('Создать задачу'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'Введите название задачи'),
              validator: _validator,
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
                  taskState.addTask(_textEditingController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Создать!'),
            )
          ],
        );

        return dialog;
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

  TextButton _createCancelButton(context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Отмена"),
    );
  }
}
