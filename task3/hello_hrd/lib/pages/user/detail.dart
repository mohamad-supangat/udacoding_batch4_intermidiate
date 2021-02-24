import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'update.dart';
import '../../bloc/user_bloc.dart';
import '../../components/components.dart';
import '../../helpers/helpers.dart';
import '../../layouts/main.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final UserBloc _userBloc = UserBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => _userBloc..add(GetUser()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile User'),
          actions: [
            IconButton(
              tooltip: 'Keluar sesi login',
              onPressed: () async {
                bool status = await Auth().logout();
                if (status) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                }
              },
              // textColor: Colors.white,
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
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
            return MainLayout(
              scrollable: true,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Card(
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
                      Container(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_circle),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nama',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(state.user.name),
                                  ],
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(Icons.account_circle_outlined),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(state.user.username),
                                  ],
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Icon(Icons.mail_rounded),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'E-Mail',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(state.user.email),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return NoItems(
              message: 'Gagal mengambil data',
              color: Colors.white,
            );
          }
        }),
        floatingActionButton:
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoaded) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UpdateUser()));
              },
              child: Icon(Icons.edit),
            );
          } else {
            return SizedBox();
          }
        }),
      ),
    );
  }
}
