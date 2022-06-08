import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'dart:io';

import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/utils.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';
import 'package:flutter_formulario/src/utils/campos.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';

/// pagina para el ingreso del documento que desemos buscar o registrar
/// la pagina despliega una dropdown-menu para elegir el tipo de documento
/// la pagina despliega un un campo para ingresar el número del documento
/// si el documento es encontrado dirige a la pagina BasicoPage
/// si el documento no se encuentra en la base de datos despliega un aviso indicando la situación.
class DocumentosPage extends StatefulWidget {
  final bool estado;

  DocumentosPage({this.estado});

  @override
  _DocumentoPageState createState() => _DocumentoPageState(estado: this.estado);
}

class _DocumentoPageState extends State<DocumentosPage> {
  final bool estado;

  _DocumentoPageState({this.estado});

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final documentoProvider = new DocumentosProvider();

  DocumentosModel documento = new DocumentosModel();
  bool _buscar = false;
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

  String titulo = "buscando documento";

  @override
  Widget build(BuildContext context) {
    final DocumentosModel documentoData =
        ModalRoute.of(context).settings.arguments;

    if (documentoData != null) {
      documento = documentoData;
    }

    if (this.estado == true) {
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
                              _crearTipo(),
                              SizedBox(
                                height: 20,
                              ),
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
          bottomNavigationBar: bottomNavigationBar(context));
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
                            _crearTipo(),
                            SizedBox(
                              height: 20,
                            ),
                            _digitarCedula(),
                            SizedBox(
                              height: 30,
                            ),
                            Text("¿Quién lo encontró?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                            SizedBox(
                              height: 15,
                            ),
                            _crearResponsable(),
                            SizedBox(
                              height: 30,
                            ),
                            _crearCelular(),
                            SizedBox(
                              height: 30,
                            ),
                            Text("¿Dondé encuentro el documento?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.0)),
                            SizedBox(
                              height: 15,
                            ),
                            _crearDireccion(),
                            _crearBoton()
                          ],
                        ),
                      ))),
            )
          ],
        ),
        bottomNavigationBar: bottomNavigationBar(context));
  }

  /// grafica los titulos de la sección
  Widget _titulos() {
    if (this.estado == false) {
      titulo = "registrando documento";
    }

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
          ],
        ),
      ),
    );
  }

  /// despliega la el dropdown con las opciones tipo de documento
  /// las opciones incluidas estan almacenadas en la variable item
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

  /// retorna el campo para digitar la cedula que deseamos buscar o registrar.
  /// la longitud del tamaño de la cedula o documento debe ser mayor a 3
  Widget _digitarCedula() {
    return TextFormField(
      initialValue: documento.numero,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.person),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Cedula',
      ),
      onSaved: (value) => documento.numero = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Digite el numero';
        } else {
          return null;
        }
      },
    );
  }

  ///despliega el formulario para digitar el nombre de la persona que encontró la cedula
  Widget _crearResponsable() {
    return TextFormField(
      initialValue: documento.responsable,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.people),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Responsable',
      ),
      onSaved: (value) => documento.responsable = value,
      validator: (value) {
        if (value.length < 1) {
          return 'ingrese el nombre del responsable';
        } else {
          return null;
        }
      },
    );
  }

  /// retorna el campo para digitar el número del celular de la persona que encontró el documento
  Widget _crearCelular() {
    return TextFormField(
      initialValue: documento.celular,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.phone),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Celular',
      ),
      onSaved: (value) => documento.celular = value,
      validator: (value) {
        if (value.length < 5) {
          return 'ingrese un número correcto de celular';
        } else {
          return null;
        }
      },
    );
  }

  /// retorna el campo para digitar la dirección donde podemos reclamar el documento perdido.
  Widget _crearDireccion() {
    return TextFormField(
      initialValue: documento.direccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.location_on),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Dirección',
      ),
      onSaved: (value) => documento.direccion = value,
      validator: (value) {
        if (value.length < 5) {
          return 'ingrese una dirección';
        } else {
          return null;
        }
      },
    );
  }

  /// despliega el botón para enviar el formulario.
  Widget _crearBoton() {
    if (this.estado == true) {
      return RaisedButton(
        shape: StadiumBorder(),
        color: Colors.blue,
        textColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text('Buscar', style: TextStyle(fontSize: 20.0))),
        onPressed: (_buscar) ? null : _submitBuscar,
      );
    } else {
      return RaisedButton.icon(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.deepPurple,
        textColor: Colors.white,
        label: Text('guardar'),
        icon: Icon(Icons.save),
        onPressed: (_guardando) ? null : _submitRegistrar,
      );
    }
  }

  /// verifica que exista un documento en base a los variables ingresadas
  /// @tipo corrresponde al tipo de documento que estamos buscando
  /// @numero corresponde al número de identificación del documento que estamos buscando
  Future<Map<String, dynamic>> existe(String tipo, String numero) async {
    List<DocumentosModel> info =
        await documentoProvider.cargarDocumento(tipo, numero);

    if (info.isNotEmpty) {
      return {'ok': true};
    }
    return {'ok': false};
  }

  /// verifica que el formulario se halla llenado correctamente
  /// si el documento existe en la base de datos, dirige a la pagina BasicoPage si es el caso de que se esté buscando
  /// si el documento no se ha encontrado se muestra una alerta
  void _submitBuscar() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _buscar = true;
    });
    DocumentosModel doc = null;

    if (documento.numero != ' ') {
      setState(() {
        _buscar = false;
      });

      Map info = await existe(documento.tipo, documento.numero);

      if (info['ok']) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BasicoPage(
                    tipo: documento.tipo,
                    data: documento.numero,
                  )),
        );
      } else {
        mostrarAlerta(context, 'documento no encontrado');
      }
    }
  }

  /// valida y registra un nuevo documento en base a los valores ingresados.
  /// si el documento se registro correctamente despliega un mensaje confirmado la operación
  void _submitRegistrar() async {
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

  /// mensaje de alerta
  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
