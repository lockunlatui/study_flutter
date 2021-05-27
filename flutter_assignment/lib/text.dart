import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final String appBarTitle;

  TextControl(this.appBarTitle);
  @override
  Widget build(BuildContext context) {
    return Text(appBarTitle);
  }
}
