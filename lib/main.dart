import 'package:flutter/material.dart';
import 'package:gestion_employe/pages/DetailPage.dart';
import 'package:gestion_employe/pages/EmployePage.dart';
import 'package:gestion_employe/pages/HomePage.dart';

void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/':(context)=>HomePage(),
        '/allEmp':(context)=>EmployePage(),
        '/detail':(context)=>DetailPage()
      },
      
    );
  }
}