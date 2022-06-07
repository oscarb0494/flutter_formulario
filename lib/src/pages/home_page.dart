import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/bloc/provider.dart';
import 'package:flutter_formulario/src/providers/llaves_provider.dart';
import 'package:flutter_formulario/src/providers/objetos_provider.dart';
import 'package:flutter_formulario/src/models/llave_model.dart';
import 'package:flutter_formulario/src/models/objeto_model.dart';
import 'package:flutter_formulario/src/widgets/menu_widget.dart';

/// no aplica para la primera iteracción
class HomePage extends StatelessWidget {
  final llavesProvider = new LlavesProvider();
  final objetosProvider = new ObjetosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('home')),
      drawer: MenuWidget(),
      body: _crearListadoObjetos(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListadoObjetos() {
    return FutureBuilder(
        future: objetosProvider.cargarObjetos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ObjetoModel>> snapshot) {
          if (snapshot.hasData) {
            final objetos = snapshot.data;

            return ListView.builder(
              itemCount: objetos.length,
              itemBuilder: (context, i) =>
                  _crearItemObjeto(context, objetos[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearListadoLlaves() {
    return FutureBuilder(
        future: llavesProvider.cargarLlaves(),
        builder:
            (BuildContext context, AsyncSnapshot<List<LlaveModel>> snapshot) {
          if (snapshot.hasData) {
            final llaves = snapshot.data;

            return ListView.builder(
              itemCount: llaves.length,
              itemBuilder: (context, i) => _crearItemLlave(context, llaves[i]),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

 
  

  Widget _crearItemLlave(BuildContext context, LlaveModel llave) {
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
              (llave.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(llave.fotoUrl),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ), //FadeInImage
              ListTile(
                title: Text(
                    '${llave.colorUno} - ${llave.colorDos} - ${llave.patron}'),
                subtitle: Text(llave.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'llave', arguments: llave),
              ),
            ], //<Widget>[]
          ), //Column
        ) //Card
        ); //Dismissible
  }

  Widget _crearItemObjeto(BuildContext context, ObjetoModel objeto) {
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
              (objeto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(objeto.fotoUrl),
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ), //FadeInImage
              ListTile(
                title: Text(
                    '${objeto.colorUno} - ${objeto.colorDos} - ${objeto.descripcion}'),
                subtitle: Text(objeto.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'objeto', arguments: objeto),
              ),
            ], //<Widget>[]
          ), //Column
        ) //Card
        ); //Dismissible
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'objeto'),
    ); //FloatingActionButton
  }
}
