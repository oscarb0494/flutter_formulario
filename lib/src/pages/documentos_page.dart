import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'dart:io';

import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';

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
	Widget build(BuildContext context){

		final DocumentosModel documentoData = ModalRoute.of(context).settings.arguments;

		if ( documentoData != null ){
			documento = documentoData;
		}

          return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          Center(
            child: SingleChildScrollView(
              child:Container(
                	padding: EdgeInsets.all(15.0),
					          child: Form(
						        key: formKey,
                    child: Column(
                      children: <Widget>[
                        _titulos(),
                        _digitarCedula(),
                        SizedBox(   //Use of SizedBox
                          height: 30,
                        ),
                        _crearBoton()
                      ],
                    ),
                  )
              )
          ),) 
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
          );
      /**
			key: scaffoldKey,
			appBar: AppBar(
				title: Text('Documentos'),
				
			),
			body: Center(
        child: SingleChildScrollView(
				child: Container(
					padding: EdgeInsets.all(15.0),
					child: Form(
						key: formKey,
						child: Column(
							children: <Widget>[
								_digitarCedula(),
								_crearBoton(),
							], //<Widget>
						), //Column
					), //Form
				), //Container
        ),  //center
			), //SingleChildScrollView
		); //Scaffold **/
	}

    Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        )
      ),
    );


    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]
          )
        ),
      )
    );
    
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaRosa
        )
      ],
    );
  }

    Widget _titulos() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('buscando documento', style: TextStyle( color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold )),
            SizedBox( height: 10.0 ),
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
        textTheme: Theme.of(context).textTheme
          .copyWith( caption: TextStyle( color: Color.fromRGBO(116, 117, 152, 1.0) ) )
      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon( Icons.calendar_today, size: 30.0 ),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.bubble_chart, size: 30.0 ),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.supervised_user_circle, size: 30.0 ),
            title: Container()
          ),
        ],
      ),
    );

  }

  OutlineInputBorder myinputborder(){ //return type is OutlineInputBorder
  return OutlineInputBorder( //Outline border type for TextFeild
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide(
        color:Colors.white,
        width: 3,
      )
  );
}

OutlineInputBorder myfocusborder(){
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(
        color:Colors.lightBlueAccent,
        width: 3,
      )
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
        
			), //InputDecoration

			onSaved: (value) => documento.cedula = value,
			validator: (value){
				if ( value.length < 3){
					return 'Digite el numero';
				} else{
					return null;
				}
			},
		); //TextFormFiled
	}

	Widget _crearBoton(){
     return RaisedButton(
          shape: StadiumBorder(),
          color: Colors.blue,
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Text('Buscar', style: TextStyle(fontSize: 20.0))
          ),
          onPressed: (_buscar) ? null : _submit,
      );
	
    /**
     * 
     * 	return RaisedButton.icon(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(20.0)
			),
			color: Colors.deepPurple,
			textColor: Colors.white,
			label: Text('Buscar'),
			icon: Icon( Icons.save ),
			onPressed: (_buscar) ? null : _submit,
		); //RaisedButton 
     */
  	
  
  }

  Future<Map<String, dynamic>> existe(String cedula) async{
    List<DocumentosModel> info = await documentoProvider.cargarDocumento(cedula);

    if(info.isNotEmpty){
      return { 'ok':true};
    }
      return { 'ok':false};
  }

	void _submit() async {
		if ( !formKey.currentState.validate() ) return;
		formKey.currentState.save();

		setState(() {_buscar = true;});
    DocumentosModel doc = null;

    if(documento.cedula != ' '){
        setState(() {_buscar = false;});

        Map info = await existe(documento.cedula);

		if ( info['ok'] ){
			  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BasicoPage(
             data: documento.cedula,
           )),
     );
		} else{
			mostrarAlerta( context, 'cedula no encontrada' );
		}}

		/**if (objeto.cedula == null){
			objetoProvider.crearObjeto(objeto);
		} else{
			objetoProvider.editarObjeto(objeto);
		}**/

		//setState(() {_buscar = false;});
		//mostrarSnackbar('buscando');
		//Navigator.pop(context);
	}

	void mostrarSnackbar(String mensaje){
		final snackbar = SnackBar(
			content: Text(mensaje),
			duration: Duration(milliseconds: 1500),
		); //snackbar

		scaffoldKey.currentState.showSnackBar(snackbar);
	}

	

}