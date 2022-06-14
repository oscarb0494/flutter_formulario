import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/objeto_model.dart';
import 'package:flutter_formulario/src/providers/objetos_provider.dart';
import 'package:flutter_formulario/src/widgets/menu_widget.dart';

/// página para la visualización de los objetos encontrados (aplicaria para documentos)
class ObjetoEncontradoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  final objetosProvider = new ObjetosProvider();

  final String categoria;
  final String colorUno;
  final String colorDos;

  ObjetoEncontradoPage({this.categoria,this.colorUno,this.colorDos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text('Objetos encontrados'),
            backgroundColor: Color.fromRGBO(55, 57, 84, 1.0),
            elevation: 0,
          ),
      body: _crearListadoDocumentos(),
    );
  }

  /// crea el listado de objetos encontrados con características similares a las diligenciadas en el formulario
  Widget _crearListadoDocumentos() {
    return FutureBuilder(
        future: objetosProvider.buscarObjeto(categoria, colorUno, colorDos),
        builder:
            (BuildContext context, AsyncSnapshot<List<ObjetoModel>> snapshot) {
          if (snapshot.hasData) {
            final objetos = snapshot.data;

            return ListView.builder(
              itemCount: objetos.length,
              itemBuilder: (context, i) =>
                  _crearItemDocumento(context, objetos[i]),
            );
          } else {
            return Center(
                child: Text(
                    "No fue encontrado ningún elemento en esta " + categoria));
          }
        });
  }

  ///
  /// crea el ítem por objeto encontrado.
  /// @context contexto de uso de la aplicación.
  /// @documento corresponde la información del documento encontrado.
  ///
  Widget _crearItemDocumento(BuildContext context, ObjetoModel objeto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          objetosProvider.borrarObjeto(objeto.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              _crearImagen(context,objeto.fotoUrl),
              _crearAcciones(context),
              _crearTexto(),
              ListTile(
                subtitle: Text('disponible'),
                title: Text(
                     '\nObjeto encontrado: \nResponsable: ${objeto.responsable} \nContacto: ${objeto.celular}\nDirección: ${objeto.direccion}'),
              ),
            ],
          ),
        ));
  }

  /// despliega una imagen del objeto encontrado (no aplica para documentos)
  /// en el caso de documentos despliega una imagen base
  /// @context contexto de uso de la aplicación.
  Widget _crearImagen(BuildContext context, String imageAddress) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage(
              imageAddress),
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// despliega una lista de items ejecutables si el documento es encontrado.
  Widget _crearAcciones(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "mapa");
            },
            child: Icon(Icons.near_me, color: Colors.blueAccent, size: 30.0)),
      ],
    );
  }

  /// crea el icono de items ejecutables si el documento es encontrado.
  Widget _accion(
      IconData icon, String texto, BuildContext context, String ruta) {
    return Column(
      children: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, ruta);
            },
            child: Icon(icon, color: Colors.white, size: 30.0)),
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(height: 5.0),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        ),
      ],
    );
  }

  /// despliega el número del documento encontrado.
  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          categoria,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}