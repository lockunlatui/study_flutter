import 'package:flutter/material.dart';

import './text.dart';

class Button extends StatelessWidget {
  final String textButton;
  final Function changeText;

  Button(this.textButton, this.changeText);
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: TextControl(textButton),
      onPressed: changeText,
    );
  }
}
