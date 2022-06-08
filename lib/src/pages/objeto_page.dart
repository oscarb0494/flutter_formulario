import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/utils/bottomNavigationBar.dart';
import 'package:flutter_formulario/src/utils/campos.dart';
import 'package:flutter_formulario/src/utils/fondo.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/objeto_model.dart';
import 'package:flutter_formulario/src/providers/objetos_provider.dart';

class ObjetoPage extends StatefulWidget {
  @override
  _ObjetoPageState createState() => _ObjetoPageState();
}

class _ObjetoPageState extends State<ObjetoPage> {
  String dropdownvalue = 'Categoría';
  var items = [
    'Categoría',
    'Maletín',
    'Casco',
    'Reloj',
    'Joya',
    'Celular',
    'Billetera'
  ];

// Color for the picker shown in Card on the screen.
  Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  Color dialogPickerColor;
  // Color for picker using the color select dialog.
  Color dialogSelectColor;

  Color paletonPickerColor;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final objetoProvider = new ObjetosProvider();

  ObjetoModel objeto = new ObjetoModel();
  bool _guardando = false;
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
    ColorTools.createAccentSwatch(Colors.black): 'Black',
    ColorTools.createAccentSwatch(Colors.amberAccent): 'Amber accent',
    ColorTools.createAccentSwatch(const Color(0xFF8A9597)): 'Silver gray',
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
    final ObjetoModel objetoData = ModalRoute.of(context).settings.arguments;

    if (objetoData != null) {
      objeto = objetoData;
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
                      _mostrarFoto(),
                      _crearColorUno(),
                      _crearColorDos(),
                      _crearPatron(),
                      _crearUso(),
                      _crearDisponible(),
                      SizedBox(
                          height: 30,
                        ),
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
                        Text("¿Dondé encuentro el documento?",
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
          title: Text('objeto'),
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

  Widget _crearColorUno() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
              pickersEnabled: <ColorPickerType, bool>{
                //ColorPickerType.accent : false
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
                    objeto.colorUno =
                        '${ColorTools.materialNameAndCode(screenPickerColor, colorSwatchNameMap: colorsNameMap)}'
                  },
              width: 20,
              height: 20,
              borderRadius: 22,
              heading: Text(
                'Color Primario',
                style: Theme.of(context).textTheme.headline6,
              )),
        ),
      ),
    );
  }

  Widget _crearColorDos() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Card(
          elevation: 2,
          child: ColorPicker(
            pickersEnabled: <ColorPickerType, bool>{
              //ColorPickerType.accent : false
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
              objeto.colorDos =
                  '${ColorTools.materialNameAndCode(paletonPickerColor, colorSwatchNameMap: customSwatches)}'
            },
            width: 20,
            height: 20,
            borderRadius: 22,
            heading: Text(
              'Color Secundario',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearPatron() {
    return DropdownButton(
      value: dropdownvalue,
      icon: Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          objeto.categoria = newValue;
          dropdownvalue = newValue;
        });
      },
    );
  }

  Widget _crearUso() {
    return TextFormField(
      initialValue: objeto.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.text_fields_outlined),
        border: myinputborder(),
        enabledBorder: myinputborder(),
        focusedBorder: myfocusborder(),
        labelText: 'Descripción',
      ),
      onSaved: (value) => objeto.descripcion = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese la descripción del objeto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: objeto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        objeto.disponible = value;
      }),
    );
  }

  Widget _crearResponsable() {
    return TextFormField(
      initialValue: objeto.responsable,
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
      onSaved: (value) => objeto.responsable = value,
      validator: (value) {
        if (value.length < 1) {
          return 'Ingrese el nombre del responsable';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearCelular() {
    return TextFormField(
      initialValue: objeto.celular,
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
      onSaved: (value) => objeto.celular = value,
      validator: (value) {
        if (value.length < 5) {
          return 'ingrese un número correcto de celular';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDireccion() {
    return TextFormField(
      initialValue: objeto.direccion,
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
      onSaved: (value) => objeto.direccion = value,
      validator: (value) {
        if (value.length < 5) {
          return 'ingrese una dirección';
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
      label: Text('Registrar'),
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
      objeto.fotoUrl = await objetoProvider.subirImagen(foto);
    }

    if (objeto.id == null) {
      objetoProvider.crearObjeto(objeto);
    } else {
      objetoProvider.editarObjeto(objeto);
    }

    setState(() {
      _guardando = false;
    });
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto() {
    if (objeto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(objeto.fotoUrl),
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
      objeto.fotoUrl = null;
    }

    setState(() {});
  }
}
