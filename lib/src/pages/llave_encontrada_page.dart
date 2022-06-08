import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/llave_model.dart';
import 'package:flutter_formulario/src/providers/llaves_provider.dart';
import 'package:flutter_formulario/src/widgets/menu_widget.dart';

/// página para la visualización de los objetos encontrados (aplicaría para documentos)
class LlaveEncontradaPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  final llavesProvider = new LlavesProvider();

  final String data;

  LlaveEncontradaPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Documentos')),
      drawer: MenuWidget(),
      body: _crearListadoDocumentos(),
    );
  }

  /// crea el listado de objetos encontrados con características similares a las diligenciadas en el formulario
  Widget _crearListadoDocumentos() {
    return FutureBuilder(
        future: llavesProvider.buscarLlave(data),
        builder:
            (BuildContext context, AsyncSnapshot<List<LlaveModel>> snapshot) {
          if (snapshot.hasData) {
            final llaves = snapshot.data;

            return ListView.builder(
              itemCount: llaves.length,
              itemBuilder: (context, i) =>
                  _crearItemDocumento(context, llaves[i]),
            );
          } else {
            return Center(
                child: Text(
                    "La cédula con número: " + data + " no fue encontrada"));
          }
        });
  }

  ///
  /// crea el ítem por objeto encontrado.
  /// @context contexto de uso de la aplicación.
  /// @documento corresponde la información del documento encontrado.
  ///
  Widget _crearItemDocumento(BuildContext context, LlaveModel llave) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          llavesProvider.borrarLlave(llave.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              _crearImagen(context,llave.fotoUrl),
              _crearAcciones(context),
              _crearTexto(),
              ListTile(
                subtitle: Text('Disponible'),
                title: Text(
                    '\n Puedes contactarte a este número, una persona lo ha encontrado \n Contacto: ${llave.id}'),
              ),
            ],
          ),
        ));
  }

  /// despliega una imágen del objeto encontrado (no aplica para documentos)
  /// en el caso de documentos despliega una imagen base
  /// @context contexto de uso de la aplicación.
  /// @imageAddress corresponde a la dirección de la imagen que visualizaremos
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

  /// despliega una lista de ítems ejecutables si el documento es encontrado.
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

  /// crea el icono de ítems ejecutables si el documento es encontrado.
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
          data,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
