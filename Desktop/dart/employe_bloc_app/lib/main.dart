import 'package:employe_bloc_app/bloc/EmployeeBloc.dart';
import 'package:employe_bloc_app/repositories/EmployeRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/AllEmployeePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create:(context)=>EmployeBloc(EmployeState(employes:[], requestState:RequestState.NONE, errorMessage:""), new EmployeRepository()))
      ] , 
      child: MaterialApp(

        routes: {
          '/':(context)=>AllEmployeePage()
        },

      )
      );
  }
}


