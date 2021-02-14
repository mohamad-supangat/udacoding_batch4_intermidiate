import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/user_bloc.dart';
import '../../helpers/helpers.dart';
import '../../components/no_items.dart';
import '../../layouts/main.dart';
import '../../repositories/user.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UserBloc _userBloc = UserBloc();

  bool _obsecurePassword = true;
  bool _obsecurePasswordConfirmation = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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

  void _saveProses() {
    // cek validasi form
    if (_formKey.currentState.validate()) {
      // call prosess api
      UserRepository.saveUser({
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirm': _confirmationPasswordController.text
      }).then((response) {
        showToast(
          type: response.data['status'] ? 'success' : 'error',
          message: response.data['message'],
        );
      });
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
                                          labelText: 'Nama Lengkap *'),
                                    ),
                                    TextFormField(
                                      controller: _emailController,
                                      validator: (String arg) =>
                                          _validatior(arg: arg, name: 'Email'),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration:
                                          InputDecoration(labelText: 'E-mail'),
                                    ),
                                    TextFormField(
                                      obscureText: this._obsecurePassword,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        helperText:
                                            'Masukan password baru untuk mengganti / biarkan kosong agar tidak merubah password',
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            Icons.remove_red_eye,
                                            color: !this._obsecurePassword
                                                ? Colors.blue
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
                                                ? Colors.red
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
