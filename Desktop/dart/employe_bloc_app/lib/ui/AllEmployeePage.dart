import 'package:employe_bloc_app/bloc/EmployeeBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

class AllEmployeePage extends StatelessWidget {
  const AllEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EmployeBloc>().add(new LoadAllEmployeEvent());
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Center(
              child: const Text(
                "Liste des employés",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [],
          ),
          BlocBuilder<EmployeBloc, EmployeState>(builder: (context, state) {
            if (state.requestState == RequestState.LOADING) {
              //print("ok");

              return const CircularProgressIndicator();
            } else if (state.requestState == RequestState.ERROR) {
              print("ok");
            } else if (state.requestState == RequestState.LOADED) {
              print("okZ");

              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${state.employes[index]['firstName']}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text("${state.employes[index]['lastName']}"),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => Divider(
                            height: 2,
                            color: Colors.black54,
                          ),
                      itemCount:
                          state.employes.isEmpty ? 0 : state.employes.length),
                ),
              );
            }

            return Text("");
          })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
