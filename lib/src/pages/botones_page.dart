import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/botones.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

import 'package:flutter_formulario/src/utils/titulos.dart';

/// pagina para escoger entre las opciones busquedad
/// la pagina despliega una lista de opciones (documentos,llaves, objetos)
/// al presionar alguna de las opciones lo debe llevar al formulario para encontrar objetos referentes a la opción elegida.
class BotonesPage extends StatelessWidget {
  final bool estado;

  BotonesPage({this.estado});

  @override
  Widget build(BuildContext context) {
    String documentoDir = "documento_register";
    String llaveDir = "llave";
    String objetoDir = "objeto";

    String titulo = "Encontré";
    String subtitulo = "Selecciona la categoría";

    if (this.estado == false) {
      documentoDir = "documento_search";
      llaveDir = "llave_search";
      objetoDir = "objeto_search";

      titulo =  "Buscando";
      subtitulo = "Selecciona lo que deseas buscar.";
    }

    return Scaffold(
        body: Stack(
          children: <Widget>[
            fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  titulos(titulo, subtitulo),
                  _botonesRedondeados(context,documentoDir,llaveDir,objetoDir)
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(context));
  }

  /// asignar estilo a los botones
  Widget _botonesRedondeados(context, documentoDir, llaveDir, objetoDir) {
    return Table(
      children: [
        TableRow(
          children: [
            crearBotonRedondeado(Colors.blueAccent, Icons.folder_open,
                'Documentos', documentoDir, context),
          ],
        ),
        TableRow(children: [
          crearBotonRedondeado(Colors.greenAccent, Icons.vpn_key_sharp,
              'Llaves', llaveDir, context),
        ]),
        TableRow(children: [
          crearBotonRedondeado(Colors.purpleAccent, Icons.directions_bus,
              'Objetos', objetoDir, context),
        ]),
      ],
    );
  }
}
