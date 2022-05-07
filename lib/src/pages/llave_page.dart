import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/llave_model.dart';
import 'package:flutter_formulario/src/providers/llaves_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart' as utils;


class LlavePage extends StatefulWidget {
	@override
	_LlavePageState createState() => _LlavePageState();
}

class _LlavePageState extends State<LlavePage> {

	final formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();
	final llaveProvider = new LlavesProvider();


	LlaveModel llave = new LlaveModel();
	bool _guardando = false;
	File foto;
 
	@override
	Widget build(BuildContext context){

		final LlaveModel llaveData = ModalRoute.of(context).settings.arguments;

		if ( llaveData != null ){
			llave = llaveData;
		}

		return Scaffold(
			key: scaffoldKey,
			appBar: AppBar(
				title: Text('llave'),
				actions: <Widget>[
					IconButton(
						icon: Icon( Icons.photo_size_select_actual ),
						onPressed: _seleccionarFoto,
					), //IconButton
					IconButton(
						icon: Icon( Icons.camera_alt ),
						onPressed: _tomarFoto,
					) //IconButton
				], // <Widget>[]
			), //appBar
			body: SingleChildScrollView(
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
								_crearBoton(),
							], //<Widget>
						), //Column
					), //Form
				), //Container
			), //SingleChildScrollView
		); //Scaffold
	}

	Widget _crearColorUno() {
		return TextFormField(
			initialValue: llave.colorUno,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'color uno'
			), //InputDecoration
			onSaved: (value) => llave.colorUno = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el color uno';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearColorDos() {
		return TextFormField(
			initialValue: llave.colorDos,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'color dos'
			), //InputDecoration
			onSaved: (value) => llave.colorDos = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el color dos';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearPatron() {
		return TextFormField(
			initialValue: llave.patron,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'patron'
			), //InputDecoration
			onSaved: (value) => llave.patron = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el paton de la llave';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearUso() {
		return TextFormField(
			initialValue: llave.uso,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'uso'
			), //InputDecoration
			onSaved: (value) => llave.uso = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese uso de la llave';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearDisponible(){
		return SwitchListTile(
			value: llave.disponible,
			title: Text('disponible'),
			activeColor: Colors.deepPurple,
			onChanged: (value)=> setState((){
				llave.disponible = value;
			}),
		);
	}

	Widget _crearBoton(){
		return RaisedButton.icon(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(20.0)
			),
			color: Colors.deepPurple,
			textColor: Colors.white,
			label: Text('guardar'),
			icon: Icon( Icons.save ),
			onPressed: (_guardando) ? null : _submit,
		); //RaisedButton 
	}

	void _submit() async {

		if ( !formKey.currentState.validate() ) return;
		formKey.currentState.save();

		setState(() {_guardando = true;});

		if (foto != null){
			llave.fotoUrl = await llaveProvider.subirImagen(foto);
		}

		if (llave.id == null){
			llaveProvider.crearLlave(llave);
		} else{
			llaveProvider.editarLlave(llave);
		}

		setState(() {_guardando = false;});
		mostrarSnackbar('registro guardado');

		Navigator.pop(context);
	}

	void mostrarSnackbar(String mensaje){
		final snackbar = SnackBar(
			content: Text(mensaje),
			duration: Duration(milliseconds: 1500),
		); //snackbar

		scaffoldKey.currentState.showSnackBar(snackbar);
	}

	Widget _mostrarFoto() {
		if(llave.fotoUrl != null){
			return FadeInImage(
				image: NetworkImage( llave.fotoUrl ),
				placeholder: AssetImage('assets/jar-loading.gif'),
				height: 300.0,
				fit: BoxFit.contain,
			);
		} else{
			if(foto == null){
				return Image(
					image: AssetImage( foto?.path ?? 'assets/no-image.png'),
					height: 300.0,
					fit: BoxFit.cover,
				);
			} else{
				return Image(
					image: FileImage(foto),
					height: 300.0,
					fit: BoxFit.cover,
				);
			}
		}
	}

	 _seleccionarFoto() async  {
	 	_procesarImagen( ImageSource.gallery );
	}

	_tomarFoto() async {
		_procesarImagen( ImageSource.camera );
	}

	_procesarImagen(ImageSource origen) async{
		foto = await ImagePicker.pickImage(
	 		source: origen,
	 	);

	 	print(foto);

	 	if( foto != null ){
	 		llave.fotoUrl = null;
	 	}

	 	setState(() {});
	}

}