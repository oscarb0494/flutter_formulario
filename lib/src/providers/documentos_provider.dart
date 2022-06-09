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

  final String token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFhZWY1NjlmNTI0MTRlOWY0YTcxMDRiNmQwNzFmMDY2ZGZlZWQ2NzciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmx1dHRlci03OWVjNiIsImF1ZCI6ImZsdXR0ZXItNzllYzYiLCJhdXRoX3RpbWUiOjE2NTQ3MzY4MTksInVzZXJfaWQiOiJwMm94V2pjQ1NwYmJGRDhiWHpzZHhWeU1YZU0yIiwic3ViIjoicDJveFdqY0NTcGJiRkQ4Ylh6c2R4VnlNWGVNMiIsImlhdCI6MTY1NDczNjgxOSwiZXhwIjoxNjU0NzQwNDE5LCJlbWFpbCI6ImRhbmllbDk5QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJkYW5pZWw5OUBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.KTt7Ip2s85w_x4r5tRCKH0yyh5uFE-YbTrZBj-Z0HI8mZLqT0WeIwTXiBrCoHGpWpSzKR7TjEKSbeKdXtfTWmqs2qxru7zmjmT7moa7cqtxZBwulh1KtFzd0wbaDm3ZzGoV3V3fM28SJjBw_56rARRsBGmTXtYosh9yyHjgvZ9PBZ3CrKBlFrBdecOaF_MYwL586sfNVaSWPVackePw0kcAPAmh_qNv1x2qNL99HX2rpCCbGjji5bVSy7WtR7fqcJnV__kF2aeF4sR9Jxjq6c6okYy6pdiPNaivk9ZQM0YiN7cTSnyE2I1xfNPs5FgVKX_qxK12PFKWNJxk09pQ_pQ";

	Future<bool> crearDocumento( DocumentosModel documento ) async{
		final url = '$_url/documentos.json?auth=${ token }';

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