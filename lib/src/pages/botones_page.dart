import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/botones.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

import 'package:flutter_formulario/src/utils/titulos.dart';

/// página para escoger entre las opciones búsqueda y registro
/// la página despliega una lista de opciones (documentos,llaves, objetos)
/// dependiendo de la variable estado la página despliega las opciones de búsqueda o registro
/// al presionar alguna de las opciones la app lo dirige a la opción seleccionada.
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
  /// @context corresponde al contexto de la app
  /// @documentoDir corresponde a la dirección para el formulario de documentos
  /// @llaveDir corresponde a la dirección para el formulario de llaves
  /// @objetoDir corresponde a la dirección para el formulario de objetos
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
