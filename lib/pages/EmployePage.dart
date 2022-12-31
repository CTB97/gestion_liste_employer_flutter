import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestion_employe/entity/Employe.dart';
import 'package:gestion_employe/pages/AjoutEmployee.dart';
import 'package:gestion_employe/pages/DetailPage.dart';
import 'package:gestion_employe/pages/Supprime.dart';
import 'package:http/http.dart' as http;

class EmployePage extends StatefulWidget {
  const EmployePage({ Key? key }) : super(key: key);

  @override
  State<EmployePage> createState() => _EmployePageState();
}

class _EmployePageState extends State<EmployePage> {
dynamic  futureEmp;  
TextEditingController firstNameController= TextEditingController();
TextEditingController lastNameController= TextEditingController();
TextEditingController EmailController= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allEmployee();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tous les employés"),
    ),
    body: Center(
      child: ListView.separated(
        itemBuilder: (context,index)=>ListTile(
          title: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [

                  Text("${futureEmp[index]['firstName']}",style: TextStyle(fontSize: 20),),
                  SizedBox(width: 40),
                  Text("${futureEmp[index]['lastName']}"),
                ],
                
              ),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.edit), onPressed: (){
                    showDialog(context: context, builder:(BuildContext context)=>updateEmploye(futureEmp[index]['firstName'],futureEmp[index]['lastName'],futureEmp[index]['emailId'])).then((value) =>{
                      if (value=="OK"){
                        update(firstNameController.text,lastNameController.text,EmailController.text,futureEmp[index]['id'],index)
                      }
                    });
                  },),
                  IconButton(icon: Icon(Icons.delete,), onPressed: (){
                    
                      showDialog(context: context, builder:(BuildContext context)=>Supprime(id:futureEmp[index]['id'])).then((value) =>{
                        if(value=="ok"){

                          setState(() {
                          supprime(futureEmp[index]['id']);
                          futureEmp.removeAt(index);
                          print(value);
                          })
                          
                        }
                      });
                    
                  },),

                ],
              )
              
            ],
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailPage(id:futureEmp[index]['id'] ,)));
          },
        ),
        separatorBuilder:(context,index)=>Divider(height:2,color:Colors.black54,),
        itemCount:futureEmp==null?0:futureEmp.length),

        
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add) ,onPressed: (){showDialog(
        context: context, 
        builder: (BuildContext context)=>ajoutEmploye()).then((value)=>{
          if(value=="OK"){

            print(firstNameController.text),
            postEmployee(firstNameController.text,lastNameController.text,EmailController.text)
            
            
          }
        })
        ;},),
    );
  }

  Widget ajoutEmploye(){
    
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
            controller: lastNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'nom',
            ),),),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: EmailController,
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
    
                

              } ,
              child: const Text('OK'),
            ),
          ],
      
    );
  }
  Widget updateEmploye(String prenom, String nom,String email){
    
    firstNameController.text=prenom;
    lastNameController.text=nom;
    EmailController.text=email;
    return AlertDialog(

      contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(child: Text("modification")),
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
            controller: lastNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'nom',
            ),),),
            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: EmailController,
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
    
                

              } ,
              child: const Text('OK'),
            ),
          ],
      
    );
  }


  void allEmployee() async{

    http.Response response= await http.get(Uri.parse("http://192.168.1.3:8082/employees"));

    if (response.statusCode==200){

      setState(() {
        futureEmp=json.decode(response.body);
        print(futureEmp);
      });

      
    }
    else{

      print("erreur");
      throw Exception("Pas d'employee");
    }

  }
  void postEmployee(String prenom,String nom,String email) async{
    http.Response response= await http.post(
    Uri.parse("http://192.168.1.3:8082/employees"),
    headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String,String>{
      'firstName':prenom,
      'lastName':nom,
      'emailId':email

    })
    );

    if(response.statusCode==200){
      setState(() {
        futureEmp.add(json.decode(response.body));
      });
    }
    else{
      print("erreur");
      throw Exception();
    }
  }
  void update(String prenom,String nom,String email,int id,int index) async{
    http.Response response= await http.put(
    Uri.parse("http://192.168.1.3:8082/employees/$id"),
    headers: <String,String>{
      'Content-Type':'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String,Object>{
      'id':id,
      'firstName':prenom,
      'lastName':nom,
      'emailId':email

    })
    );

    if(response.statusCode==200){
      setState(() {
        futureEmp[index]= json.decode(response.body);
      });
    }
    else{
      print("erreur");
      throw Exception();
    }
  }
  void supprime(int id){

    http.delete(
    Uri.parse('http://192.168.1.3:8082/employees/$id'));

  }
}