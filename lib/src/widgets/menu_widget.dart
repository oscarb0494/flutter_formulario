import 'package:flutter/material.dart';
import 'package:flutter_formulario/src/pages/home_page.dart';
import 'package:flutter_formulario/src/pages/llave_page.dart';
import 'package:flutter_formulario/src/pages/objeto_page.dart';

class MenuWidget extends StatelessWidget{
	@override
	Widget build(BuildContext context){
		return Drawer(
			child: ListView(
				padding: EdgeInsets.zero,
				children: <Widget>[
					DrawerHeader(
						child: Container(),
						decoration: BoxDecoration(
							image: DecorationImage(
								image: AssetImage('assets/menu-img.jpg'),
								fit: BoxFit.cover
							) //decorationImage
						), //boxDecoration  
					), //DrawerHeader

					ListTile(
						leading: Icon(Icons.pages, color: Colors.blue),
						title: Text('Home'),
						onTap: ()=> Navigator.pushReplacementNamed(context, 'home' ),
					), //ListTile

					ListTile(
						leading: Icon(Icons.party_mode, color: Colors.blue),
						title: Text('Party Mode'),
						onTap: (){ },
					), //ListTile

					ListTile(
						leading: Icon(Icons.people, color: Colors.blue),
						title: Text('Objetos'),
						onTap: (){
							Navigator.pushReplacementNamed(context, 'objeto');
						},
					), //ListTile

					ListTile(
						leading: Icon(Icons.settings, color: Colors.blue),
						title: Text('Llaves'),
						onTap: (){
							//Navigator.pop(context);
							Navigator.pushReplacementNamed(context, 'llave');
						},
					), //ListTile

				], // </Widhet>[]
			), //ListView
		); //Drawer
	}
}