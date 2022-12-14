import 'package:flutter/material.dart';
import 'package:task_app/widgets/branch/dialog/cancel_button.dart';
import 'package:flutter/services.dart';

class RedactBranchDialog extends StatefulWidget {
  const RedactBranchDialog({super.key, required this.currentTitle});

  final String currentTitle;

  @override
  State<StatefulWidget> createState() => _RedactBranchDialogState();
}

class _RedactBranchDialogState extends State<RedactBranchDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.currentTitle;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
        const CancelButton(text: 'Отмена'),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _textController.text);
            }
          },
          child: const Text("Ок"),
        )
      ],
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
