import 'package:flutter/material.dart';

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
							)
						), 
					), 

					ListTile(
						leading: Icon(Icons.pages, color: Colors.blue),
						title: Text('Home'),
						onTap: ()=> Navigator.pushReplacementNamed(context, 'home' ),
					), 

					ListTile(
						leading: Icon(Icons.party_mode, color: Colors.blue),
						title: Text('Party Mode'),
						onTap: (){ },
					), 

					ListTile(
						leading: Icon(Icons.people, color: Colors.blue),
						title: Text('Objetos'),
						onTap: (){
							Navigator.pushReplacementNamed(context, 'objeto');
						},
					), 

					ListTile(
						leading: Icon(Icons.settings, color: Colors.blue),
						title: Text('Llaves'),
						onTap: (){
							//Navigator.pop(context);
							Navigator.pushReplacementNamed(context, 'llave');
						},
					), 

					ListTile(
						leading: Icon(Icons.settings, color: Colors.blue),
						title: Text('App'),
						onTap: (){
							//Navigator.pop(context);
							Navigator.pushReplacementNamed(context, 'scroll');
						},
					), 

					ListTile(
						leading: Icon(Icons.settings, color: Colors.blue),
						title: Text('registro documentos'),
						onTap: (){
							//Navigator.pop(context);
							Navigator.pushReplacementNamed(context, 'documento_register');
						},
					), 

				], 
			), 
		); 
	}
}