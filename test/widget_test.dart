// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'package:flutter_formulario/src/pages/basico_page.dart';
import 'package:flutter_formulario/src/pages/botones_page.dart';
import 'package:flutter_formulario/src/pages/documentos_page.dart';
import 'package:flutter_formulario/src/pages/scroll_page.dart';
import 'package:flutter_formulario/src/providers/documentos_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /**
   * prueba unitaria
   * verifica que un documento se haya creado correctamente.
   */
  test('Registro exitoso de documento', () {
    DocumentosProvider provider = new DocumentosProvider();

    DocumentosModel documento = new DocumentosModel(
        tipo: "C.C.",
        numero: "123456789",
        responsable: "oscar buritica",
        celular: "3116479809",
        direccion: "Cra. 26, 49-46, Manizales");

    Future<bool> resultado = provider.crearDocumento(documento);
    resultado["param"];

    Future<bool> esperado = Future<bool>.value(true).then((value) => value);

    expect(resultado, esperado);
  });

/**
 * prueba general de sistema
 * prueba para verificar que la vista resultado de consulta sea generada correctamente
 * la prueba busca que los campos Contacto y Responsable sean desplegados por la app
 */
  testWidgets('mi widget de respuesta genera el formato responsable, contacto',
      (WidgetTester tester) async {
    await tester.pumpWidget(BasicoPage(data: '1053836250'));

    final titleFinder = find.text('Contacto:');
    final messageFinder = find.text('Responsable:');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });

/**
 * prueba general de sistema
 * prueba para verificar el correcto despliegue de la pagina del formulario de busquedad del documento
 */
  testWidgets('formulario de busquedad', (WidgetTester tester) async {
    await tester.pumpWidget(DocumentosPage(estado: true));

    final titleFinder = find.text('buscando documento');

    expect(titleFinder, findsOneWidget);
  });

/**
 * prueba general de sistema
 * prueba para verificar el correcto despliegue de la pagina del formulario de busquedad del documento
 */
  testWidgets('formulario de busquedad, titulo de la app',
      (WidgetTester tester) async {
    await tester.pumpWidget(ScrollPage());

    final titleFinder = find.text('Application');

    expect(titleFinder, findsOneWidget);
  });

/**
 * prueba general de sistema
 * metodo para verificar el despliegue de la ventana principal.
 * la prueba busca que la ventana despliegue el titulo de la app de manera correcta.
 * la prueba busca que la pantalla no genere ningun aviso de error.
 */
  testWidgets('pantalla inicial', (WidgetTester tester) async {
    await tester.pumpWidget(ScrollPage());

    final titleFinder = find.text('Find Me');
    final messageFinder = find.text('Error');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsNothing);
  });

/**
 * prueba general de sistema
 * prueba para verificar el despliegue de la pantalla de botones que dirigen a los formularios de consulta
 * la prueba verifica el correcto despliegue de los 3 botones: Documentos, Llaves, Objetos
 */
  testWidgets('pantalla botones', (WidgetTester tester) async {
    await tester.pumpWidget(BotonesPage());

    final buttonDocumentos = find.text('Documentos');
    final buttonLlaves = find.text('Llaves');
    final buttonObjetos = find.text('Objetos');

    expect(buttonDocumentos, findsOneWidget);
    expect(buttonLlaves, findsOneWidget);
    expect(buttonObjetos, findsOneWidget);
  });
}
