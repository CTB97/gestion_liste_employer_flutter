import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {

  final id;
  
  const DetailPage({this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  dynamic emp;
  final double coverHight = 280;
  final double profileHight=144;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    one();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body:ListView(
        padding: EdgeInsets.zero,
        children: [
          buildTop(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(emp==null?"":"${emp['firstName']} ${emp['lastName']}",style: TextStyle(fontSize: 28,height:1.6,fontWeight: FontWeight.bold,)),
                Text(emp==null?"":"${emp['emailId']}",style: TextStyle(fontSize: 20,height:1.4,fontWeight: FontWeight.normal ),)
                
                
              ],
            ),
          )
        ],
      )
      
    );
  }

  Widget buildCoverImage(){
    return Container(
      color: Colors.grey,
      child:Image.asset("images/cover.jpg",
      width: double.infinity,
      height: coverHight,
      fit: BoxFit.cover,)
      
    );
  }
  Widget buildProfileImage(){

    return CircleAvatar(

      radius: profileHight/2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: const AssetImage("images/cover.png"),

    );
  }

  Widget buildTop(){

    return  Stack(
        clipBehavior: Clip.none,
        alignment:Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 70),
            child:buildCoverImage(),
          ),
          
          Positioned(
            top: coverHight-profileHight/2,
            child:buildProfileImage() )
          
        ],
      ) ;
  }

  void one() async{

    http.Response response = await http.get(Uri.parse("http://192.168.1.3:8082/employees/${widget.id}"));

    if(response.statusCode==200){

      setState(() {
         emp=json.decode(response.body);
         print(emp['firstName']);
      });

     
    }
    else{
      print("err");
      throw Exception();
      
    }

  }
  
}