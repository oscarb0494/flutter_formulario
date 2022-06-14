import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_formulario/src/models/documentos_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter_formulario/src/preferencias_usuario/preferencias_usuario.dart';

/// maneja los datos provenientes de la base de datos referente a documentos
class DocumentosProvider {
	final String _url = 'https://flutter-79ec6-default-rtdb.firebaseio.com';
	final _prefs = new PreferenciasUsuario();

	Future<bool> crearDocumento( DocumentosModel documento ) async{
		final url = '$_url/documentos.json?auth=${_prefs.token}';

		final resp = await http.post(url, body: documentosModelToJson(documento) );

		final decodedData = json.decode(resp.body);
		print( decodedData );

		return true;
	}

	Future<bool> editarDocumento( DocumentosModel documento ) async{
		final url = '$_url/documentos/${ documento.id }.json?auth=${ _prefs.token }';

		final resp = await http.put(url, body: documentosModelToJson(documento) );
		final decodedData = json.decode(resp.body);
		
		print( decodedData );

		return true;
	}

	Future<List<DocumentosModel>> cargarDocumentos() async{
		final url = '$_url/documentos.json?auth=${ _prefs.token }';
		final resp = await http.get(url);

		final Map<String,dynamic> decodedData = json.decode(resp.body);
		final List<DocumentosModel> documentos = new List();

		if (decodedData == null ) return [];

		decodedData.forEach((id, doc ){
			final docTemp = DocumentosModel.fromJson(doc);
			docTemp.id = id;

			documentos.add( docTemp );
		});

		print( documentos );
		return documentos;
	}

	Future <List<DocumentosModel>> cargarDocumento(String tipo,String numero) async{
		final url = '$_url/documentos.json?auth=${ _prefs.token }';
		final resp = await http.get(url);

		final Map<String,dynamic> decodedData = json.decode(resp.body);
		final List<DocumentosModel> documentos = new List();

		if (decodedData == null ) return [];

		decodedData.forEach((id, doc){
			final docTemp = DocumentosModel.fromJson(doc);

      print(docTemp.numero);

			if (docTemp.tipo == tipo && docTemp.numero == numero){
				print("entra");
				print(docTemp);
				docTemp.id = id;
				documentos.add( docTemp );
			}	
		});

		return documentos;
	}

	Future<int> borrarDocumento(String id) async{
		final url = '$_url/documentos/$id.json?auth=${ _prefs.token }';
		final resp = await http.delete(url);

		print( json.decode(resp.body) );
		return 1;
	}

	Future<String> subirImagen(File imagen) async{
		final url = Uri.parse('https://api.cloudinary.com/v1_1/dun3q6j0s/image/upload?upload_preset=voo4bmtg');
		final mimeType = mime(imagen.path).split('/');

		final imageUploadRequest = http.MultipartRequest(
			'POST',
			url
		);

		final file = await http.MultipartFile.fromPath(
			'file',
			imagen.path,
			contentType: MediaType( mimeType[0], mimeType[1])
		);

		imageUploadRequest.files.add(file);

		final streamResponse = await imageUploadRequest.send();

		final resp = await http.Response.fromStream(streamResponse);

		if (resp.statusCode != 200 && resp.statusCode != 201){
			print('algo salio mal');
			print(resp.body);
			return null;
		}

		final respData = json.decode(resp.body);
		print( respData );

		return respData['secure_url'];
	}
}