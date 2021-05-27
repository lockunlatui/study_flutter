import 'package:flutter/material.dart';

import './text.dart';
import './button.dart';

class App extends StatelessWidget {
  final String appBarTitle;
  final Function changeText;

  static const text = 'Change Text';

  App(this.appBarTitle, this.changeText);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: TextControl(appBarTitle),
            ),
            body: Center(child: Button(text, changeText))));
  }
}
