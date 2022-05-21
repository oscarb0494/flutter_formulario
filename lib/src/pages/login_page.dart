import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/bloc/provider.dart';
import 'package:flutter_formulario/src/providers/usuarios_provider.dart';
import 'package:flutter_formulario/src/utils/utils.dart';

/**
 * no aplica para la primera iteracción
 */
class LoginPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ], //<Widget>[]
    ) //Stack
        ); //Scaffold
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ), //container
          ), //safeArea

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ], //boxShadow[]
            ), //Boxdecoration

            child: Column(
              children: <Widget>[
                Text('ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
              ], //<Widget>[]
            ), //Column
          ), //container

          FlatButton(
            child: Text('crear una nueva cuenta'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'registro'),
          ), //FlatButton
          SizedBox(height: 100.0)
        ], //<Widget>[]
      ), //Column
    ); //SingleChildScrollView
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'ejemplo@correo.com',
                labelText: 'correo electronico',
                counterText: snapshot.data,
                errorText: snapshot.error), //inputDecoration
            onChanged: bloc.changeEmail,
          ), //TextField
        ); //container
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext content, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error), //inputDecoration
            onChanged: bloc.changePassword,
          ), //TextField
        ); //container
      },
    ); //StreamBuilder
  }

  Widget _crearBoton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('ingresar'),
          ), //container
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        ); //RaisedButton
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushNamed(context, 'home');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ] //<Color>[]
              ) //LinearGrafient
          ), //BoxDecoration
    ); //Container

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)), //BoxDecoration
    ); //Container

    return Stack(
      children: <Widget>[
        fondoMorado,

        Positioned(top: 90.0, left: 30.0, child: circulo), //Positioned
        Positioned(top: -40.0, right: -30.0, child: circulo), //Positioned
        Positioned(bottom: -50.0, right: -10.0, child: circulo), //Positioned
        Positioned(bottom: 120.0, right: 20.0, child: circulo), //Positioned
        Positioned(bottom: -50.0, left: -20.0, child: circulo), //Positioned

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('social network',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ], //<Widget>[]
          ), //Column
        ), //Container
      ], // <Widget>[]
    ); //Stack
  }
}
