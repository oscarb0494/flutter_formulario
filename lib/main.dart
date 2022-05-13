import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';
import 'package:flutter_formulario/src/pages/botones_page.dart';
import 'package:flutter_formulario/src/pages/documentos_page.dart';
import 'package:flutter_formulario/src/pages/login_page.dart';
import 'package:flutter_formulario/src/pages/home_page.dart';
import 'package:flutter_formulario/src/pages/mapa_page.dart';
import 'package:flutter_formulario/src/pages/producto_page.dart';
import 'package:flutter_formulario/src/pages/registro_page.dart';
import 'package:flutter_formulario/src/pages/llave_page.dart';
import 'package:flutter_formulario/src/pages/objeto_page.dart';
import 'package:flutter_formulario/src/bloc/provider.dart';
import 'package:flutter_formulario/src/pages/scroll_page.dart';
import 'package:flutter_formulario/src/pages/documentos_register_page.dart';
import 'package:flutter_formulario/src/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print( prefs.token );

    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: 'login',
        routes: {
          'basic'   : (BuildContext context) => BasicoPage(),
          'scroll'  : (BuildContext context ) => ScrollPage(),
          'botones' : (BuildContext context ) => BotonesPage(),
          'documento_search' : (BuildContext context ) => DocumentosPage(),
          'login'   : (BuildContext context) => LoginPage(),
          'home'    : (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'llave'   : (BuildContext context) => LlavePage(),
          'objeto'  : (BuildContext contex) => ObjetoPage(),
          'documento_register'  : (BuildContext contex) => DocumentosRegisterPage(),
          'mapa':  (BuildContext contex) => MapScreen(),
        },
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          ),
      )
    );

  }

}

