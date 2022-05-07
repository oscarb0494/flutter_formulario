import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/objeto_model.dart';
import 'package:flutter_formulario/src/providers/objetos_provider.dart';

class ObjetoPage extends StatefulWidget {
	@override
	_ObjetoPageState createState() => _ObjetoPageState();
}

class _ObjetoPageState extends State<ObjetoPage> {

	final formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();
	final objetoProvider = new ObjetosProvider();

	ObjetoModel objeto = new ObjetoModel();
	bool _guardando = false;
	File foto;
 
	@override
	Widget build(BuildContext context){

		final ObjetoModel objetoData = ModalRoute.of(context).settings.arguments;

		if ( objetoData != null ){
			objeto = objetoData;
		}

		return Scaffold(
			key: scaffoldKey,
			appBar: AppBar(
				title: Text('objeto'),
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
								_crearForma(),
								_crearTexto(),
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
			initialValue: objeto.colorUno,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'color uno'
			), //InputDecoration
			onSaved: (value) => objeto.colorUno = value,
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
			initialValue: objeto.colorDos,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'color dos'
			), //InputDecoration
			onSaved: (value) => objeto.colorDos = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el color dos';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearForma() {
		return TextFormField(
			initialValue: objeto.forma,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'patron'
			), //InputDecoration
			onSaved: (value) => objeto.forma = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el paton del objeto';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearTexto() {
		return TextFormField(
			initialValue: objeto.texto,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'uso'
			), //InputDecoration
			onSaved: (value) => objeto.texto = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese uso de la objeto';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearDisponible(){
		return SwitchListTile(
			value: objeto.disponible,
			title: Text('disponible'),
			activeColor: Colors.deepPurple,
			onChanged: (value)=> setState((){
				objeto.disponible = value;
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
			objeto.fotoUrl = await objetoProvider.subirImagen(foto);
		}

		if (objeto.id == null){
			objetoProvider.crearObjeto(objeto);
		} else{
			objetoProvider.editarObjeto(objeto);
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
		if(objeto.fotoUrl != null){
			return FadeInImage(
				image: NetworkImage( objeto.fotoUrl ),
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
	 		objeto.fotoUrl = null;
	 	}

	 	setState(() {});
	}

}