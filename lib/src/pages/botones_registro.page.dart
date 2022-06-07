import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/botones.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

import 'package:flutter_formulario/src/utils/titulos.dart';

/// pagina para escoger entre las opciones busquedad
/// la pagina despliega una lista de opciones (documentos,llaves, objetos)
/// al presionar alguna de las opciones lo debe llevar al formulario para encontrar objetos referentes a la opción elegida.
class BotonesRegistroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  titulos("Encontré", "Selecciona la categoría"),
                  _botonesRedondeados(context)
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(context));
  }

  /// asignar estilo a los botones
  Widget _botonesRedondeados(context) {
    return Table(
      children: [
        TableRow(
          children: [
            crearBotonRedondeado(Colors.blueAccent, Icons.folder_open,
                'Documentos', 'documento_register', context),
          ],
        ),
        TableRow(children: [
          crearBotonRedondeado(Colors.greenAccent, Icons.vpn_key_sharp,
              'Llaves', 'llave', context),
        ]),
        TableRow(children: [
          crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus,
              'Objetos', 'objeto', context),
        ]),
      ],
    );
  }
}
