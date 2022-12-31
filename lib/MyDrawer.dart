import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child:ListView(
        padding: EdgeInsets.all(10),
        children: [
          const DrawerHeader(
            child: Text("MENU",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
            ),
          ListTile(
            title: Text("Accueil",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.home),

            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            
          ),
          ListTile(
            title: Text("liste des employés",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            leading: Icon(Icons.people),

            onTap: () {
              Navigator.pushNamed(context, "/allEmp");
            },
            
          ),
          
        ],
      ),
      
    );
  }

  
}