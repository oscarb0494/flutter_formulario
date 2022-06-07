import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/bloc/provider.dart';
import 'package:flutter_formulario/src/providers/productos_provider.dart';
import 'package:flutter_formulario/src/providers/llaves_provider.dart';
import 'package:flutter_formulario/src/providers/objetos_provider.dart';
import 'package:flutter_formulario/src/models/llave_model.dart';
import 'package:flutter_formulario/src/widgets/menu_widget.dart';

/// no aplica para la primera iteracción
class HomePageLlaves extends StatelessWidget {
  final productosProvider = new ProductosProvider();
  final llavesProvider = new LlavesProvider();
  final objetosProvider = new ObjetosProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('home')),
      drawer: MenuWidget(),
      body: _crearListadoLlaves(),
      floatingActionButton: _crearBoton(context),
    );
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
                    ),
              ListTile(
                title: Text(
                    '${llave.colorUno} - ${llave.colorDos} - ${llave.patron}'),
                subtitle: Text(llave.id),
                onTap: () =>
                    Navigator.pushNamed(context, 'llave', arguments: llave),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'llave'),
    );
  }
}
