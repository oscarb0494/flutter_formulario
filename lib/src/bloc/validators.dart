import 'dart:async';

class Validators{

/// verifica que un email ingresado cumpla el formato de un email
/// el metodo retorna error si el email no cumple el formato
	final validarEmail = StreamTransformer<String,String>.fromHandlers(
		handleData: (email,sink){
			Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
			RegExp regExp = new RegExp(pattern);

			if(regExp.hasMatch(email)){
				sink.add( email );
			} else{
				sink.addError('email no es correcto');
			}
		}
	);

/// verifica que la contraseña ingresada en el proceso de inscripcion tenga mas de 6 caracteres
/// retorna un error si la contraseña es menor a 6 caracteres
/// aprueba la contraseña si esta es mayor a 6 caracteres
	final validarPassword = StreamTransformer<String,String>.fromHandlers(
		handleData: (password,sink){
			if(password.length >= 6){
				sink.add(password);
			}else{
				sink.addError('Mas de 6 caracteres');
			}
		}
	);

}