import 'dart:convert';

import 'package:employe_bloc_app/models/Employee.dart';
import 'package:http/http.dart' as http;
class EmployeRepository{

  Future allEmployee() async{

    http.Response response= await http.get(Uri.parse("http://192.168.1.4:8082/employees"));

    if (response.statusCode==200){

      return json.decode(response.body);
      
    }
    else{
      throw Exception("Erreur internet");
    }

  }
  dynamic oneEmploye(int id) async{

    http.Response response = await http.get(Uri.parse("http://192.168.1.4:8082/employees/${id}"));

    if(response.statusCode==200){

      return json.decode(response.body);
     
    }
    else{
      throw Exception("Erreur Internet");      
    }

  }
}