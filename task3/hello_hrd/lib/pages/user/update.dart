import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/user_bloc.dart';
import '../../helpers/helpers.dart';
import '../../components/no_items.dart';
import '../../layouts/main.dart';
import '../../database.dart';
import '../../models/user.dart';

class UpdateUser extends StatefulWidget {
  @override
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final DBProvider _db = DBProvider();
  final UserBloc _userBloc = UserBloc();

  bool _obsecurePassword = true;
  bool _obsecurePasswordConfirmation = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmationPasswordController =
      TextEditingController();

  _validatior({arg, name}) {
    if (arg == '')
      return '$name tidak boleh kosong';
    else if (arg.length < 3)
      return '$name harus lebih dari 5 karakter';
    else
      return null;
  }

  void _saveProses() async {
    final User _oldUser = await Auth().getUser();

    try {
      if (_formKey.currentState.validate()) {
        // call prosess api
        final String _newPassword = _passwordController.text;

        final User user = await _db.updateUser(
          User.fromJson({
            'name': _nameController.text,
            'username': _usernameController.text,
            'email': _emailController.text,
            'password': _newPassword == '' || _newPassword == null
                ? _oldUser.password
                : _newPassword,
          }),
          _oldUser.id,
        );

        if (user != null) {
          showToast(
            type: 'success',
            message: 'Menyimpan perubahan',
          );
        }
      }
    } catch (e) {
      showToast(
        type: 'error',
        message: 'Gagal Menyimpan perubahan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Profile'),
      ),
      body: MainLayout(
        child: BlocProvider<UserBloc>(
          create: (context) => _userBloc..add(GetUser()),
          child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
            if (state is UserInitial) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.white,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    height: 100,
                  ),
                ),
              );
            } else if (state is UserLoaded) {
              _usernameController.text = state.user.username;
              _nameController.text = state.user.name;
              _emailController.text = state.user.email;

              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(width: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            state.user.name
                                                .substring(0, 2)
                                                .toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 60,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      validator: (String arg) => _validatior(
                                          arg: arg, name: 'Nama Lengkap'),
                                      decoration: InputDecoration(
                                        labelText: 'Nama Lengkap *',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _usernameController,
                                      validator: (String arg) {
                                        final generalResult = _validatior(
                                            arg: arg, name: 'Username');
                                        if (generalResult != null) {
                                          return generalResult;
                                        } else {
                                          RegExp usernameRegExp = RegExp(
                                            r"^[^\W_]+$",
                                            caseSensitive: false,
                                            multiLine: false,
                                          );

                                          if (usernameRegExp.hasMatch(arg) ==
                                              false) {
                                            return 'Username yang anda masukan tidak valid';
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Username *',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _emailController,
                                      validator: (String arg) {
                                        final generalResult = _validatior(
                                            arg: arg, name: 'E-mail');
                                        if (generalResult != null) {
                                          return generalResult;
                                        } else {
                                          RegExp emailRegExp = RegExp(
                                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                                            caseSensitive: false,
                                            multiLine: false,
                                          );

                                          if (emailRegExp.hasMatch(arg) ==
                                              false) {
                                            return 'Email yang anda masukan tidak valid';
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'E-mail *',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      obscureText: this._obsecurePassword,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        helperText:
                                            'Masukan password baru untuk mengganti / biarkan kosong agar tidak merubah password',
                                        labelText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: !this._obsecurePassword
                                                ? Colors.teal
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() =>
                                                this._obsecurePassword =
                                                    !this._obsecurePassword);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      obscureText:
                                          this._obsecurePasswordConfirmation,
                                      controller:
                                          _confirmationPasswordController,
                                      validator: (String arg) {
                                        if (arg != _passwordController.text) {
                                          return 'Password dan password konfirmasi tidak sama';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Konfirmasi Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: !this
                                                    ._obsecurePasswordConfirmation
                                                ? Colors.teal
                                                : Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() => this
                                                    ._obsecurePasswordConfirmation =
                                                !this
                                                    ._obsecurePasswordConfirmation);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _saveProses(),
                  child: Icon(Icons.save),
                ),
              );
            } else {
              return NoItems(
                message: 'Gagal mengambil data',
                color: Colors.white,
              );
            }
          }),
        ),
      ),
    );
  }
}
