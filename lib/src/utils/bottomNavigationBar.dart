import 'package:flutter/material.dart';

/// despliega la barra inferior de la app.
Widget bottomNavigationBar(BuildContext context) {
  return Theme(
    data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0), title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart, size: 30.0), title: Container()),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle, size: 30.0),
            title: Container()),
      ],
    ),
  );
}
