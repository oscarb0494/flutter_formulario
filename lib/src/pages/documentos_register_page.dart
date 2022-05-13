import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart' as utils;


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
 
	@override
	Widget build(BuildContext context){

		final DocumentosModel documentoData = ModalRoute.of(context).settings.arguments;

		if ( documentoData != null ){
			documento = documentoData;
		}

		return Scaffold(
			key: scaffoldKey,
			appBar: AppBar(
				title: Text('documento'),
			), //appBar
			body: SingleChildScrollView(
				child: Container(
					padding: EdgeInsets.all(15.0),
					child: Form(
						key: formKey,
						child: Column(
							children: <Widget>[
								_crearCedula(),
								_crearBoton(),
							], //<Widget>
						), //Column
					), //Form
				), //Container
			), //SingleChildScrollView
		); //Scaffold
	}

	Widget _crearCedula() {
		return TextFormField(
			initialValue: documento.cedula,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'cedula'
			), //InputDecoration
			onSaved: (value) => documento.cedula = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese la cedula que encontro';
				} else{
					return null;
				}
			},
		); //TextFormFiled
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
			documento.fotoUrl = await documentoProvider.subirImagen(foto);
		}

		if (documento.id == null){
			documentoProvider.crearDocumento(documento);
		} else{
			documentoProvider.editarDocumento(documento);
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
		if(documento.fotoUrl != null){
			return FadeInImage(
				image: NetworkImage( documento.fotoUrl ),
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
	 		documento.fotoUrl = null;
	 	}

	 	setState(() {});
	}

}