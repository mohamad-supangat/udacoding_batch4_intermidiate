import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'employee/form_action.dart';
import '../bus.dart';
import '../bloc/list_employees.dart';
import '../layouts/main.dart';
import '../components/components.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Data Pegawai'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_sharp),
            tooltip: 'Detail user',
            onPressed: () {
              Navigator.of(context).pushNamed('/user/detail');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EmployeeFormAction()));
        },
        tooltip: 'Tambah data Pegawai',
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: MainLayout(
        child: Container(
          child: BlocProvider<ListEmployeesBloc>(
            create: (context) => ListEmployeesBloc()..add(GetListEmployees()),
            child: BlocBuilder<ListEmployeesBloc, ListEmployeesState>(
                builder: (context, state) {
              print('state sekarang');
              print(state.toString());
              if (state is ListEmployeesInitial) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.white,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is ListEmployeesLoaded) {
                Future<void> _refresh() async {
                  BlocProvider.of<ListEmployeesBloc>(context).add(
                    RefreshListEmployees(),
                  );
                }

                eventBus.on<RefreshListEmployeesBus>().listen((event) {
                  _refresh();
                });

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    children: state.employees
                        .map<Widget>(
                          (employee) => Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployeeFormAction(
                                      employee: employee,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee.name,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Posisi : ' + employee.position,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 12,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          employee.phoneNumber,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 12,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          employee.email,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.place,
                                          size: 12,
                                          color: Colors.teal,
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            employee.address,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }
              return NoItems(
                color: Colors.white,
                message: 'Terjadi error pengambilan data',
              );
            }),
          ),
        ),
      ),
    );
  }
}
