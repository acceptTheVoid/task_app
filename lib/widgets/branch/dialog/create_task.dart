import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'cancel_button.dart';

class TaskCreationDialog extends StatefulWidget {
  const TaskCreationDialog({super.key});

  @override
  State<StatefulWidget> createState() => _TaskCreationDialogState();
}

class _TaskCreationDialogState extends State<TaskCreationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        const CancelButton(text: 'Отмена'),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _textEditingController.text);
            }
          },
          child: const Text('Создать!'),
        )
      ],
    );
  }
}
