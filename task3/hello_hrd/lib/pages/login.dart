import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../components/components.dart';
import '../helpers/helpers.dart';
import '../database.dart';
import '../models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final DBProvider _db = DBProvider();

  bool _obsecurePassword = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cekSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.teal,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Wave(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                IconLogo(),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Username',
                                prefixIcon: Icon(Icons.account_circle),
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (String arg) {
                                if (arg == '')
                                  return 'username tidak boleh kosong';
                                else if (arg.length < 3)
                                  return 'username harus lebih dari 5 karakter';
                                else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: this._obsecurePassword,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: !this._obsecurePassword
                                        ? Colors.teal
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() => this._obsecurePassword =
                                        !this._obsecurePassword);
                                  },
                                ),
                                filled: true,
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock_sharp),
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (String arg) {
                                if (arg == '')
                                  return 'Password tidak boleh kosong';
                                else if (arg.length < 5)
                                  return 'Password harus lebih dari 5 karakter';
                                else
                                  return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RawMaterialButton(
                              fillColor: Colors.teal,
                              elevation: 0,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: _loginButton(),
                              padding: EdgeInsets.all(8),
                              onPressed: () {
                                // cek validasi form
                                if (_formKey.currentState.validate()) {
                                  // cek user login proses
                                  _prosesLogin();
                                } else {
                                  showToast(
                                    type: 'error',
                                    message: _checkValidationText(),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Belum punya akun ?'),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed('/register'),
                                  child: Text(
                                    'Daftar',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _loginButton() {
    if (_isLoading) {
      return Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chevron_right,
              color: Colors.teal,
            ),
          ),
          Text(
            'MASUK SEKARANG',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      );
    }
  }

  // pengecekan form input
  String _checkValidationText() {
    if (_usernameController.text == '')
      return 'username tidak boleh kosong';
    else if (_usernameController.text.length < 5)
      return 'username tidak boleh kurang dari 5 karakter';
    else if (_passwordController.text == '')
      return 'Password tidak boleh kosong';
    else if (_passwordController.text.length < 5)
      return 'Password tidak boleh kurang dari 5 karakter';
    else {
      return 'Validasi gagal';
    }
  }

  void _cekSession() async {
    User _user = await Auth().userAuth();
    if (_user != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home',
        (Route<dynamic> route) => false,
      );
    }
  }

  // // proses pengecekan login
  Future<void> _prosesLogin() async {
    setState(() => _isLoading = true);
    try {
      User _user = await _db.getUserLogin(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (_user == null) {
        showToast(
            type: 'error',
            message: "Username / Password yang anda masukan salah");
      } else {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString(
          'auth',
          jsonEncode(_user).toString(),
        );

        // pindahkan page ke HomePage
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (Route<dynamic> route) => false,
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
