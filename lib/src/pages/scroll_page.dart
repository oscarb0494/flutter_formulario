import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/pages/botones_page.dart';

///
/// pagina inicial de la app
/// despliega una ventana inicial con la presentación de la aplicación
class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      children: <Widget>[_pagina1(), _pagina2(context)],
    ));
  }

  /// despliega la presentación inicial de la app
  Widget _pagina1() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  /// retorna un container usado de fondo para la app.
  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
    );
  }

  /// retorna una de fondo para la pagina inicial de la app.
  Widget _imagenFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage('assets/scroll-1.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  /// retorna el nombre de la app en la pagina inicial de la app.
  Widget _textos() {
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 50.0);

    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          //Text('11°', style: estiloTexto ),
          Text('Find Me', style: estiloTexto),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white)
        ],
      ),
    );
  }

  /// retorna una pagína con las opciones de uso de la app.
  Widget _pagina2(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 1.0),
      child: Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 120,
          ),
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Text('Estoy buscando algo',
                    style: TextStyle(fontSize: 20.0))),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BotonesPage(estado: false)),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          RaisedButton(
            shape: StadiumBorder(),
            color: Colors.blue,
            textColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Text('Encontré algo', style: TextStyle(fontSize: 20.0))),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BotonesPage(estado: true)),
            ),
          )
        ],
      )),
    );
  }
}
