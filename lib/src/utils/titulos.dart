import 'package:flutter/material.dart';

/// despliega el titulo de la sección
Widget titulos(String titulo, String mensaje) {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(titulo,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10.0),
          Text(mensaje, style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ],
      ),
    ),
  );
}
