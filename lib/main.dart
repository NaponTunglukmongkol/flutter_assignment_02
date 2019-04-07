import 'package:flutter/material.dart';
import './ui/todo_screen.dart';
import './ui/addlist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{ //Change screen
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      initialRoute: '/',
      routes: {
        "/": (context) => TodoScreen(),
        "/add": (context) => AddScreen(),
      },
    );
  }

}
