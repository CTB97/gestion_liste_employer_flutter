import 'package:bloc/bloc.dart';
import 'package:employe_bloc_app/models/Employee.dart';
import 'package:employe_bloc_app/repositories/EmployeRepository.dart';

abstract class EmployeEvent{}

class LoadAllEmployeEvent extends EmployeEvent{}

class LoadOneEmployeEvent extends EmployeEvent{}

enum RequestState{
  LOADING, LOADED, ERROR,NONE
}

class EmployeState{

  List employes;

  late RequestState requestState;

  late String errorMessage;

  EmployeState({
    required this.employes,
    required this.requestState,
    required this.errorMessage

  });


}

class EmployeBloc extends Bloc<EmployeEvent,EmployeState>{
  EmployeRepository employeRepository;
  EmployeBloc(EmployeState initialState, this.employeRepository) : super(initialState){

    on<LoadAllEmployeEvent>(_mapAllEmployeEventToState);
    
  }

  void _mapAllEmployeEventToState(LoadAllEmployeEvent event,Emitter emit) async{

    emit(EmployeState(employes:state.employes, requestState: RequestState.LOADING, errorMessage:""));
    try{
      print("ok1");
      List data= await employeRepository.allEmployee();
      print(data[0]['firstName']);
      emit(EmployeState(employes:data, requestState:RequestState.LOADED, errorMessage:""));

    }
    catch(exception){

      emit(EmployeState(employes : state.employes, requestState:RequestState.ERROR, errorMessage:exception.toString()));
      print("exception ${exception}");

    }

     

  }

}