import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key, required this.text});

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
