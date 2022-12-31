import 'package:flutter/material.dart';

class AjoutEmployee extends StatelessWidget {

  TextEditingController firstNameController= TextEditingController();
  TextEditingController lastNameController= TextEditingController();
  TextEditingController EmailController= TextEditingController();
  
   AjoutEmployee({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(

      contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(child: Text("Ajout Employee")),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              //height: 200,
              //width: 300,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: firstNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'prénom',
            ),),),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'nom',
            ),),),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Email',
            ),),),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: (){

                Navigator.pop(context, 'OK');
                //print(firstNameController.text);

              } ,
              child: const Text('OK'),
            ),
          ],
      
    );
  }
}