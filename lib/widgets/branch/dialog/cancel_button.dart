import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, this.text = 'Отмена'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(text),
    );
  }
}
