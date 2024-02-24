import 'package:flutter/material.dart';

class ChangeButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool disabled;

  const ChangeButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Text(text),
    );
  }
}
