import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/utils/campos.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

/// posiblemente se debe eliminar no aplica para la primera iteracción
class DocumentosRegisterPage extends StatefulWidget {
  @override
  _DocumentosRegisterPageState createState() => _DocumentosRegisterPageState();
}

class _DocumentosRegisterPageState extends State<DocumentosRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final documentoProvider = new DocumentosProvider();

  DocumentosModel documento = new DocumentosModel();
  bool _guardando = false;
  File foto;

  String dropdownvalue = 'Tipo de documento';
  var items = [
    'Tipo de documento',
    'Tarjeta de identidad',
    'C.C.',
    'C.E.',
    'Pasaporte',
    'Nit',
    'Licencia de conducción'
  ];

  @override
  Widget build(BuildContext context) {
    final DocumentosModel documentoData =
        ModalRoute.of(context).settings.arguments;

    if (documentoData != null) {
      documento = documentoData;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('documento'),
      ),
      body: Stack(children: <Widget>[
        fondoApp(),
        Center(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _crearTipo(),
                  SizedBox(
                    height: 20,
                  ),
                  _crearCedula(),
                  _crearBoton(),
                ],
              ),
            ),
          ),
        ))
      ]),
    );
  }

  Widget _crearTipo() {
    return DropdownButtonFormField(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.people),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
      ),
      onChanged: (String newValue) {
        setState(() {
          documento.tipo = newValue;
          dropdownvalue = newValue;
        });
      },
    );
  }

  Widget _crearCedula() {
    return TextFormField(
      initialValue: documento.numero,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.people),
          border: myinputborder(),
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
          labelText: 'cedula'),
      onSaved: (value) => documento.numero = value,
      validator: (value) {
        if (value.length < 3) {
          return 'ingrese la cedula que encontro';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      documento.fotoUrl = await documentoProvider.subirImagen(foto);
    }

    if (documento.id == null) {
      documentoProvider.crearDocumento(documento);
    } else {
      documentoProvider.editarDocumento(documento);
    }

    setState(() {
      _guardando = false;
    });
    mostrarSnackbar('registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    ); //snackbar

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
