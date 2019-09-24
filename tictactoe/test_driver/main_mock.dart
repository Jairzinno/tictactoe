import 'package:flutter/material.dart';

import 'core/test_app.dart';

void main({@required Widget home}) => runApp(MockApp(home: home));

class MockApp extends StatelessWidget {
  final Widget home;

  const MockApp({Key key, this.home}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(primaryColor: Color(0xFF613f8d)),
      home: TestApp(
        home: home,
      ),
    );
  }
}
