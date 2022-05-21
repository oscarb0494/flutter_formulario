import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'dart:io';

import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';
import 'package:flutter_formulario/src/utils/campos.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';

/**
 * pagina para el ingreso del documento que desemos buscar
 * la pagina despliega un formulario con un campo para ingresar el número del documento buscado.
 * si el documento es encontrado dirige a la pagina BasicoPage
 * si el documento no se encuentra en la base de datos despliega un aviso indicando la situación.
 */
class DocumentosPage extends StatefulWidget {
  @override
  _DocumentoPageState createState() => _DocumentoPageState();
}

class _DocumentoPageState extends State<DocumentosPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final documentoProvider = new DocumentosProvider();

  DocumentosModel documento = new DocumentosModel();
  bool _buscar = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    final DocumentosModel documentoData =
        ModalRoute.of(context).settings.arguments;

    if (documentoData != null) {
      documento = documentoData;
    }

    return Scaffold(
        body: Stack(
          children: <Widget>[
            fondoApp(),
            Center(
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            _titulos(),
                            _digitarCedula(),
                            SizedBox(
                              height: 30,
                            ),
                            _crearBoton()
                          ],
                        ),
                      ))),
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context));
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('buscando documento',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

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

  Widget _digitarCedula() {
    return TextFormField(
      initialValue: documento.cedula,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.people),
        border: myinputborder(), //normal border
        enabledBorder: myinputborder(), //enabled border
        focusedBorder: myfocusborder(), //focused border
        labelText: 'Cedula',
      ),
      onSaved: (value) => documento.cedula = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Digite el numero';
        } else {
          return null;
        }
      },
    );
  }

/**
 * despliega el botón para enviar el formulario.
 */
  Widget _crearBoton() {
    return RaisedButton(
      shape: StadiumBorder(),
      color: Colors.blue,
      textColor: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Text('Buscar', style: TextStyle(fontSize: 20.0))),
      onPressed: (_buscar) ? null : _submit,
    );
  }

  Future<Map<String, dynamic>> existe(String cedula) async {
    List<DocumentosModel> info =
        await documentoProvider.cargarDocumento(cedula);

    if (info.isNotEmpty) {
      return {'ok': true};
    }
    return {'ok': false};
  }

/**
 * verifica que el formulario se halla llenado correctamente
 * si el documento existe en la base de datos, dirige a la pagina BasicoPage
 * si el documento no se ha encontrado se muestra una alerta
 */
  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _buscar = true;
    });
    DocumentosModel doc = null;

    if (documento.cedula != ' ') {
      setState(() {
        _buscar = false;
      });

      Map info = await existe(documento.cedula);

      if (info['ok']) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BasicoPage(
                    data: documento.cedula,
                  )),
        );
      } else {
        mostrarAlerta(context, 'cedula no encontrada');
      }
    }
  }

/**
 * mensaje de alerta
 */
  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
