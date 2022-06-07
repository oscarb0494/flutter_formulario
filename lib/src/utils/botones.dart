import 'package:flutter/material.dart';
import 'dart:ui';

Widget crearBotonRedondeado(
    Color color, IconData icono, String texto, String ruta, context) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ruta);
                    },
                    child: Icon(icono, color: Colors.white, size: 30.0))
                //Icon( icono, color: Colors.white, size: 30.0 ),
                ),
            Text(texto, style: TextStyle(color: color)),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    ),
  );
}
