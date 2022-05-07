import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_formulario/src/models/producto_model.dart';
import 'package:flutter_formulario/src/providers/productos_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart' as utils;


class ProductoPage extends StatefulWidget {
	@override
	_ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {

	final formKey = GlobalKey<FormState>();
	final scaffoldKey = GlobalKey<ScaffoldState>();
	final productoProvider = new ProductosProvider();


	ProductoModel producto = new ProductoModel();
	bool _guardando = false;
	File foto;
 
	@override
	Widget build(BuildContext context){

		final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

		if ( prodData != null ){
			producto = prodData;
		}

		return Scaffold(
			key: scaffoldKey,
			appBar: AppBar(
				title: Text('producto'),
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
								_crearNombre(),
								_crearPrecio(),
								_crearDisponible(),
								_crearBoton(),
							], //<Widget>
						), //Column
					), //Form
				), //Container
			), //SingleChildScrollView
		); //Scaffold
	}

	Widget _crearNombre() {
		return TextFormField(
			initialValue: producto.titulo,
			textCapitalization: TextCapitalization.sentences,
			decoration: InputDecoration(
				labelText: 'producto'
			), //InputDecoration
			onSaved: (value) => producto.titulo = value,
			validator: (value){
				if ( value.length < 3){
					return 'ingrese el nombre del producto';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}


	Widget _crearPrecio () {
		return TextFormField(
			initialValue: producto.valor.toString(),
			keyboardType: TextInputType.numberWithOptions(decimal: true),
			decoration: InputDecoration(
				labelText: 'precio'
			), //InputDecoration
			onSaved: (value) => producto.valor = double.parse(value),
			validator: (value){
				if ( utils.isNumeric(value) ){
					return null;
				} else{
					return 'Solo numeros';
				}
			},
		); //TextFormFiled
	}

	Widget _crearDisponible(){
		return SwitchListTile(
			value: producto.disponible,
			title: Text('disponible'),
			activeColor: Colors.deepPurple,
			onChanged: (value)=> setState((){
				producto.disponible = value;
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
			producto.fotoUrl = await productoProvider.subirImagen(foto);
		}

		if (producto.id == null){
			productoProvider.crearProducto(producto);
		} else{
			productoProvider.editarProducto(producto);
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
		if(producto.fotoUrl != null){
			return FadeInImage(
				image: NetworkImage( producto.fotoUrl ),
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
	 		producto.fotoUrl = null;
	 	}

	 	setState(() {});
	}

}