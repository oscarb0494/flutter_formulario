import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_formulario/src/widgets/menu_widget.dart';

/**
 * pagina para la visualización de los objetos encontrados (aplicaria para documentos)
 */
class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  final documentosProvider = new DocumentosProvider();

  final String data;

  BasicoPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Documentos')),
      drawer: MenuWidget(),
      body: _crearListadoDocumentos(),
    );
  }

/**
 * crea el listado de objetos encontrados con caracteristicas similares a las diligenciadas en el formulario
 */
  Widget _crearListadoDocumentos() {
    return FutureBuilder(
        future: documentosProvider.cargarDocumento(data),
        builder: (BuildContext context,
            AsyncSnapshot<List<DocumentosModel>> snapshot) {
          if (snapshot.hasData) {
            final documentos = snapshot.data;

            return ListView.builder(
              itemCount: documentos.length,
              itemBuilder: (context, i) =>
                  _crearItemDocumento(context, documentos[i]),
            );
          } else {
            return Center(
                child: Text(
                    "la cedula con numero: " + data + " no fue encontrada"));
          }
        });
  }

/**
 * 
 * crea el item por objeto encontrado.
 * @context contexto de uso de la aplicación.
 * @documento corresponde la información del documento encontrado.
 * 
 */
  Widget _crearItemDocumento(BuildContext context, DocumentosModel documento) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          documentosProvider.borrarDocumento(documento.id);
        },
        child: Card(
          child: Column(
            children: <Widget>[
              _crearImagen(context),
              _crearAcciones(context),
              _crearTexto(),
              ListTile(
                subtitle: Text('disponible'),
                title: Text(
                    '\n Puedes contactarte a este numero, una persona lo ha encontrado \n Contacto: ${documento.celular}'),
              ),
            ],
          ),
        ));
  }

/**
 * despliega una imagen del objeto encontrado (no aplica para documentos)
 * en el caso de documentos despliega una imagen base
 * @context contexto de uso de la aplicación.
 */
  Widget _crearImagen(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'scroll'),
        child: Image(
          image: NetworkImage(
              'https://res.cloudinary.com/universidaddecaldasflutter/image/upload/v1652284044/cedula_oqptwl.png'),
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

/**
 * despliega el titulo de la sección.
 */
  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Cedula encontrada', style: estiloTitulo),
                  SizedBox(height: 7.0),
                  Text(data, style: estiloSubTitulo),
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0),
            Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

/**
 * despliega una lista de items ejecutables si el documento es encontrado.
 */
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

/**
 * crea el icono de items ejecutables si el documento es encontrado.
 */
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

/**
 * despliega el número del documento encontrado.
 */
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
