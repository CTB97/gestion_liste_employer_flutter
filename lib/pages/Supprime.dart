import 'package:flutter/material.dart';
import 'package:gestion_employe/pages/EmployePage.dart';
import 'package:http/http.dart' as http;

class Supprime extends StatelessWidget {
  final id;
  const Supprime({this.id});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Text("Suppression"),
      content: Container(
        child: Text("vous confirmez"),
      ),
      actions: <Widget>[
        TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => {
                //supprime(this.id),
                Navigator.pop(context, 'ok')

              },
              child: const Text('OK'),
            ),
      ],
      
    );
  }

  void supprime(int id){

    http.delete(
    Uri.parse('http://192.168.1.10:8082/employees/$id'));

  }
}