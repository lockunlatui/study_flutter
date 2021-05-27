import 'package:flutter/material.dart';

import './app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _appBarTitle = 'Home';

  void _changeText() {
    if (_appBarTitle == 'Home') {
      setState(() {
        _appBarTitle = 'Home Changed';
      });
    } else {
      setState(() {
        _appBarTitle = 'Home';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return App(_appBarTitle, _changeText);
  }
}
