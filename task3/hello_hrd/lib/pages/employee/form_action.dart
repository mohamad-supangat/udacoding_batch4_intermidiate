import 'package:flutter/material.dart';

import '../../bus.dart';
import '../../models/employee.dart';
import '../../layouts/main.dart';
import '../../database.dart';
import '../../helpers/helpers.dart';

class EmployeeFormAction extends StatefulWidget {
  final Employee employee;

  EmployeeFormAction({
    this.employee,
  });

  @override
  _EmployeeFormActionState createState() => _EmployeeFormActionState();
}

class _EmployeeFormActionState extends State<EmployeeFormAction> {
  final DBProvider _db = DBProvider();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  bool _isLoading = false;

  // fungsi untuk membuat pesan validasi
  _validatior({arg, name}) {
    if (arg == '')
      return '$name tidak boleh kosong';
    else if (arg.length < 5)
      return '$name harus lebih dari 5 karakter';
    else
      return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _nameController.text = widget.employee.name;
      _emailController.text = widget.employee.email;
      _phoneNumberController.text = widget.employee.phoneNumber;
      _addressController.text = widget.employee.address;
      _positionController.text = widget.employee.position;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (widget.employee != null ? 'Ubah' : 'Tambah') + ' Data Pegawai'),
        elevation: 0,
      ),
      body: MainLayout(
        scrollable: true,
        child: Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (String arg) =>
                            _validatior(arg: arg, name: 'Nama Lengkap'),
                        decoration: InputDecoration(
                          labelText: 'Nama Lengkap *',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        validator: (String arg) {
                          final generalResult =
                              _validatior(arg: arg, name: 'E-mail');
                          if (generalResult != null) {
                            return generalResult;
                          } else {
                            RegExp emailRegExp = RegExp(
                              r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                              caseSensitive: false,
                              multiLine: false,
                            );

                            if (emailRegExp.hasMatch(arg) == false) {
                              return 'Email yang anda masukan tidak valid';
                            } else {
                              return null;
                            }
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'E-mail *',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _phoneNumberController,
                        validator: (String arg) {
                          final generalResult =
                              _validatior(arg: arg, name: 'No. Telephone');
                          if (generalResult != null) {
                            return generalResult;
                          } else {
                            RegExp regExp = RegExp(
                              r"^[0-9]*$",
                              caseSensitive: false,
                              multiLine: false,
                            );

                            if (regExp.hasMatch(arg) == false) {
                              return 'No. Telp yang anda masukan tidak valid';
                            } else {
                              return null;
                            }
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'No. Telphone',
                          prefixText: '+62 ',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        maxLines: 5,
                        validator: (String arg) =>
                            _validatior(arg: arg, name: 'Alamat'),
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Alamat *',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _positionController,
                        validator: (String arg) =>
                            _validatior(arg: arg, name: 'Jabatan'),
                        decoration: InputDecoration(
                          labelText: 'Jabatan *',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Simpan perubahan',
        child: () {
          if (!_isLoading) {
            return Icon(Icons.save);
          } else {
            return SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        }(),
        onPressed: () => _saveProcess(),
      ),
    );
  }

  Future<void> _saveProcess() async {
    if (_formKey.currentState.validate() && !_isLoading) {
      setState(() => _isLoading = true);
      try {
        final Employee _employeeData = Employee(
          name: _nameController.text,
          email: _emailController.text,
          phoneNumber: _phoneNumberController.text,
          address: _addressController.text,
          position: _positionController.text,
          gender: 'other',
        );
        Employee _employeeResult;

        if (widget.employee == null) {
          _employeeResult = await _db.addEmployee(_employeeData);
        } else {
          _employeeResult =
              await _db.updateEmployee(_employeeData, widget.employee.id);
        }

        if (_employeeResult.id != null) {
          eventBus.fire(RefreshListEmployeesBus());
          showToast(type: 'success', message: 'Sukses menyimpan data pegawai');
          Navigator.of(context).pushNamed('/home');
        } else {
          showToast(type: 'error', message: 'Gagal menyimpan data pegawai');
        }
      } catch (_) {
        showToast(type: 'error', message: 'Terjadi kesalahan system');
      } finally {
        setState(() => _isLoading = false);
      }
    } else {
      showToast(type: 'error', message: 'Data yang anda masukan belum benar');
    }
  }
}
