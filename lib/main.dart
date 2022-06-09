import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';
import 'package:flutter_formulario/src/pages/botones_page.dart';
import 'package:flutter_formulario/src/pages/scroll_page.dart';
import 'package:flutter_formulario/src/pages/home_page.dart';

import 'package:flutter_formulario/src/pages/documentos_page.dart';
import 'package:flutter_formulario/src/pages/llave_page.dart';
import 'package:flutter_formulario/src/pages/objeto_page.dart';
import 'package:flutter_formulario/src/pages/objeto_search_page.dart';
import 'package:flutter_formulario/src/pages/mapa_page.dart';

import 'package:flutter_formulario/src/pages/llave_encontrada_page.dart';
import 'package:flutter_formulario/src/pages/login_page.dart';
import 'package:flutter_formulario/src/pages/registro_page.dart';

import 'package:flutter_formulario/src/bloc/provider.dart';
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
    print(prefs.token);

    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'login',
      routes: {
        'basic': (BuildContext context) => BasicoPage(),
        'basic_llave': (BuildContext context) => LlaveEncontradaPage(),
        'scroll': (BuildContext context) => ScrollPage(),
        'botones': (BuildContext context) => BotonesPage(),
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'registro': (BuildContext context) => RegistroPage(),
        'llave': (BuildContext context) => LlavePage(estado: true),
        'llave_search': (BuildContext context) => LlavePage(estado: false),
        'objeto': (BuildContext contex) => ObjetoPage(),
        'objeto_search': (BuildContext context) => ObjetoSearchPage(),
        'documento_register': (BuildContext contex) => DocumentosPage(estado: false),
        'documento_search': (BuildContext context) => DocumentosPage(estado: true),
        'mapa': (BuildContext contex) => MapScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
    ));
  }
}
