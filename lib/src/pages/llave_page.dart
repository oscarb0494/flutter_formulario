import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/utils.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/llave_model.dart';
import 'package:flutter_formulario/src/providers/llaves_provider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

import 'package:flutter_formulario/src/utils/campos.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';

import 'llave_encontrada_page.dart';

/// página para el ingreso de la información que desemos buscar o registrar.
/// si el documento es encontrado dirige a la pagina LlaveEncontradaPage.
/// si la llave no se encuentra en la base de datos despliega un aviso indicando la situación.
/// el formulario que se despliega puede ser de registro y consulta, dependiendo del valor booleano de la variable estado
class LlavePage extends StatefulWidget {
  final bool estado;

  LlavePage({this.estado});

  @override
  _LlavePageState createState() => _LlavePageState(estado: this.estado);
}

class _LlavePageState extends State<LlavePage> {
  final bool estado;

  _LlavePageState({this.estado});

  String dropdownvalue = 'Patrón';
  var items = ['Patrón', 'Antigua', 'Moderna', 'Lisas', 'Normal', 'Pequeña'];

  Color screenPickerColor; // Color for the picker shown in Card on the screen.
  Color dialogPickerColor; // Color for the picker in a dialog using onChanged.
  Color dialogSelectColor; // Color for picker using the color select dialog.
  Color paletonPickerColor;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final llaveProvider = new LlavesProvider();

  LlaveModel llave = new LlaveModel();
  bool _guardando = false;
  bool _buscar = false;
  File foto;

  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  final Map<ColorSwatch<Object>, String> customSwatches =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(const Color(0xFFCDA434)): 'Golden',
    ColorTools.createAccentSwatch(const Color(0xFFE3E4E5)): 'Silver',
  };

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
    paletonPickerColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final LlaveModel llaveData = ModalRoute.of(context).settings.arguments;

    if (llaveData != null) {
      llave = llaveData;
    }

    if (this.estado == true) {
      return Scaffold(
          key: scaffoldKey,
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
                        _mostrarFoto(),
                        _crearColorUno(),
                        _crearColorDos(),
                        _crearPatron(),
                        _crearMarca(),
                        SizedBox(height: 30),
                        _crearUso(),
                        _crearDisponible(),
                        SizedBox(height: 30),
                        Text("¿Quién lo encontró?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
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
                        Text("¿Dónde encuentro la llave?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                        SizedBox(
                          height: 15,
                        ),
                        _crearDireccion(),
                        _crearBoton(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ]),
          appBar: AppBar(
            title: Text('llave'),
            backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.photo_size_select_actual),
                onPressed: _seleccionarFoto,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _tomarFoto,
              )
            ],
          ),
          bottomNavigationBar: bottomNavigationBar(context));
    }

    return Scaffold(
        key: scaffoldKey,
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
                      _crearColorUno(),
                      _crearColorDos(),
                      _crearPatron(),
                      SizedBox(
                        height: 20,
                      ),
                      _crearMarca(),
                      SizedBox(
                        height: 20,
                      ),
                      _crearBotonBuscar(),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
        appBar: AppBar(
          title: Text('llave'),
          backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
          elevation: 0,
        ),
        bottomNavigationBar: bottomNavigationBar(context));
  }

  /// retorna un colorPicker para escoger el color de la cabeza de la llave
  Widget _crearColorUno() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
              pickersEnabled: <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: false,
              },
              enableShadesSelection: false,
              // Use the screenPickerColor as start color.
              color: screenPickerColor,
              // Update the screenPickerColor using the callback.
              onColorChanged: (Color color) => {
                    setState(() => screenPickerColor = color),
                    llave.colorUno =
                        '${ColorTools.materialNameAndCode(screenPickerColor, colorSwatchNameMap: colorsNameMap)}'
                  },
              width: 20,
              height: 20,
              borderRadius: 22,
              heading: Text(
                'Color de la cabeza',
                style: Theme.of(context).textTheme.headline6,
              )),
        ),
      ),
    );
  }

  /// despliega un color picker para escoger el color del paleton de la llave
  /// las opiones son: plata y dorado
  Widget _crearColorDos() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
            pickersEnabled: <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.bw: false,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: false,
            },
            customColorSwatchesAndNames: customSwatches,
            enableShadesSelection: false,
            // Use the screenPickerColor as start color.
            color: paletonPickerColor,
            // Update the screenPickerColor using the callback.
            onColorChanged: (Color color) => {
              setState(() => paletonPickerColor = color),
              llave.colorDos =
                  '${ColorTools.materialNameAndCode(paletonPickerColor, colorSwatchNameMap: customSwatches)}'
            },
            width: 20,
            height: 20,
            borderRadius: 22,
            heading: Text(
              'Color paletón',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  /// retorna una lista despeglable para escoger el patrón de la llave
  Widget _crearPatron() {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          llave.patron = newValue;
          dropdownvalue = newValue;
        });
      },
    );
  }

  /// retorna el campo para ingresar una marca de llave.
  /// no es una campo obligatorio.
  Widget _crearMarca() {
    return TextFormField(
      initialValue: llave.uso,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.emoji_objects_outlined),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Marca',
      ),
      onSaved: (value) => llave.uso = value,
    );
  }

  /// retorna una campo para ingresar el uso de la llave
  /// no es un campo obligatorio
  Widget _crearUso() {
    return TextFormField(
      initialValue: llave.uso,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.people),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'uso',
      ),
      onSaved: (value) => llave.uso = value,
    );
  }

  /// retorna una campo para declarar el estado de la llave
  Widget _crearDisponible() {
    return SwitchListTile(
      value: llave.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        llave.disponible = value;
      }),
    );
  }

  ///despliega el formulario para digitar el nombre de la persona que encontró la llave.
  Widget _crearResponsable() {
    return TextFormField(
      initialValue: llave.responsable,
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
      onSaved: (value) => llave.responsable = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese el nombre del responsable';
        } else {
          return null;
        }
      },
    );
  }

  /// retorna el campo para digitar el número del celular de la persona que encontró la llave.
  Widget _crearCelular() {
    return TextFormField(
      initialValue: llave.celular,
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
      onSaved: (value) => llave.celular = value,
      validator: (value) {
        if (value.length < 5) {
          return 'Ingrese un número correcto de celular';
        } else {
          return null;
        }
      },
    );
  }

  /// retorna el campo para digitar la dirección donde podemos reclamar el documento perdido.
  Widget _crearDireccion() {
    return TextFormField(
      initialValue: llave.direccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.location_on),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Dirección / Ubicación',
      ),
      onSaved: (value) => llave.direccion = value,
      validator: (value) {
        if (value.length < 5) {
          return 'Ingrese una dirección';
        } else {
          return null;
        }
      },
    );
  }

  /// retorna el botón para buscar en caso de que el formulario se despliegue como formulario de registro.
  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  /// retorna el botón para buscar en caso de que el formulario se despliegue como formulario de busquedad.
  Widget _crearBotonBuscar() {
    return RaisedButton(
      shape: StadiumBorder(),
      color: Colors.blue,
      textColor: Colors.white,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Text('Buscar', style: TextStyle(fontSize: 20.0))),
      onPressed: (_buscar) ? null : _submitBuscar,
    );
  }

  /// verifica que el formulario se hubiese diligenciado correctamente
  /// si la llave existe en la base de datos, dirige a la página LlaveEncontradaPage, si es el caso de que se esté buscando.
  /// si el documento no se ha encontrado se muestra una alerta.
  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      llave.fotoUrl = await llaveProvider.subirImagen(foto);
    }

    if (llave.id == null) {
      llaveProvider.crearLlave(llave);
    } else {
      llaveProvider.editarLlave(llave);
    }

    setState(() {
      _guardando = false;
    });
    
    mostrarAlerta(context, "registro exitoso");
  }

  Future<Map<String, dynamic>> existe(String colorUno) async {
    List<LlaveModel> info = await llaveProvider.buscarLlave(colorUno);

    if (info.isNotEmpty) {
      return {'ok': true};
    }
    return {'ok': false};
  }

  void _submitBuscar() async {
    print(llave.colorUno);
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _buscar = true;
    });

    if (llave.colorUno != ' ') {
      setState(() {
        _buscar = false;
      });

      Map info = await existe(llave.colorUno);

      if (info['ok']) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LlaveEncontradaPage(
                    data: llave.colorUno,
                  )),
        );
      } else {
        mostrarAlerta(context, 'Documento no encontrado');
      }
    }
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (llave.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(llave.fotoUrl),
        placeholder: AssetImage('assets/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (foto == null) {
        return Image(
          image: AssetImage(foto?.path ?? 'assets/no-image.png'),
          height: 300.0,
          fit: BoxFit.cover,
        );
      } else {
        return Image(
          image: FileImage(foto),
          height: 300.0,
          fit: BoxFit.cover,
        );
      }
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(
      source: origen,
    );

    print(foto);

    if (foto != null) {
      llave.fotoUrl = null;
    }

    setState(() {});
  }
}
