import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

import 'dart:ui';

/**
 * pagina para escoger entre las opciones busquedad
 * la pagina despliega una lista de opciones (documentos,llaves, objetos)
 * al presionar alguna de las opciones lo debe llevar al formulario para encontrar objetos referentes a la opción elegida.
 */
class BotonesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[_titulos(), _botonesRedondeados(context)],
              ),
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

/**
 * despliega el titulo de la sección
 */
  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Buscando',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Selecciona lo que deseas buscar',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }

/**
 * despliega la barra inferior de la app.
 */
  Widget _bottomNavigationBar(BuildContext context) {
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

/**
 * asignar estilo a los botones
 */
  Widget _botonesRedondeados(context) {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blueAccent, Icons.folder_open,
                'Documentos', 'documento_search', context),
          ],
        ),
        TableRow(children: [
          _crearBotonRedondeado(Colors.greenAccent, Icons.vpn_key_sharp,
              'Llaves', 'documento_search', context),
        ]),
        TableRow(children: [
          _crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus,
              'Objetos', 'documento_search', context),
        ]),
      ],
    );
  }

  Widget _crearBotonRedondeado(
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
}
