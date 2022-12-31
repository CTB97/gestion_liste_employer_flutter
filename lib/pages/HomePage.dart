import 'package:flutter/material.dart';
import 'package:gestion_employe/MyDrawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("page d'accueil"),
      ),
      body: Center(
        child: Image.asset("images/tele.jpg"),
      ),
      drawer: MyDrawer(),
      
    );
  }
}