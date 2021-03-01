import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'employee/form_action.dart';

import '../bus.dart';
import '../database.dart';
import '../bloc/list_employees.dart';
import '../layouts/main.dart';
import '../components/components.dart';
import 'employee/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DBProvider _db = DBProvider();
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
                Future<void> _refresh() async {
                  BlocProvider.of<ListEmployeesBloc>(context).add(
                    RefreshListEmployees(),
                  );
                }

                eventBus.on<RefreshListEmployeesBus>().listen((event) {
                  _refresh();
                });

                Future<void> deleteEmployee(int _id) async {
                  final id = await _db.deleteEmployee(_id);
                  if (id != null) {
                    Navigator.of(context).pop();
                    _refresh();
                  }
                }

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
                  Future<void> _showDetailPage(employee) async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailEmployee(employee)));
                  }

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
                              child: ListTile(
                                leading: IconButton(
                                  icon: Icon(Icons.visibility),
                                  onPressed: () => _showDetailPage(employee),
                                ),
                                onTap: () =>  _showDetailPage(employee),
                                contentPadding: EdgeInsets.all(5),
                                title: Text(employee.name),
                                subtitle: Text(employee.position),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        title: Text(
                                          'Informasi',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Apakah anda yakin akan menghapus data pegawai  ?',
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                employee.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            child: Text('Ya'),
                                            onPressed: () =>
                                                deleteEmployee(employee.id),
                                          ),
                                          FlatButton(
                                            child: Text('Tidak'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  );
                }
                if (state is ListEmployeesNoItems) {
                  return NoItems(
                    color: Colors.white,
                    message: 'Tidak ditemukan data pegawai',
                  );
                }
                return NoItems(
                  color: Colors.white,
                  message: 'Terjadi error pengambilan data',
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
