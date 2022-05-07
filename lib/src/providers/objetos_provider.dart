import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_formulario/src/models/objeto_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter_formulario/src/preferencias_usuario/preferencias_usuario.dart';


class ObjetosProvider {
	final String _url = 'https://flutter-79ec6-default-rtdb.firebaseio.com';
	final _prefs = new PreferenciasUsuario();

	Future<bool> crearObjeto( ObjetoModel objeto ) async{
		final url = '$_url/objetos.json?auth=${ _prefs.token }';

		final resp = await http.post(url, body: objetoModelToJson(objeto) );

		final decodedData = json.decode(resp.body);
		print( decodedData );

		return true;
	}

	Future<bool> editarObjeto( ObjetoModel objeto ) async{
		final url = '$_url/objetos/${ objeto.id }.json?auth=${ _prefs.token }';

		final resp = await http.put(url, body: objetoModelToJson(objeto) );
		final decodedData = json.decode(resp.body);
		
		print( decodedData );

		return true;
	}

	Future<List<ObjetoModel>> cargarObjetos() async{
		final url = '$_url/objetos.json?auth=${ _prefs.token }';
		final resp = await http.get(url);

		final Map<String,dynamic> decodedData = json.decode(resp.body);
		final List<ObjetoModel> objetos = new List();

		if (decodedData == null ) return [];

		decodedData.forEach((id, obj ){
			final objTemp = ObjetoModel.fromJson(obj);
			objTemp.id = id;

			objetos.add( objTemp );
		});

		print( objetos );
		return objetos;
	}

	Future<int> borrarObjeto(String id) async{
		final url = '$_url/objetos/$id.json?auth=${ _prefs.token }';
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