import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../layouts/main.dart';
import '../bloc/bloc.dart';
import 'popular_video/list.dart';
import 'popular_video/chart.dart';
import 'favorite/list.dart';
import 'profile/detail.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages = [
    ListPopularVideos(),
    ChartPopularVideos(),
    ListFavoriteVideos(),
    DetailProfile(),
  ];

  int _indexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainLayout(scrollable: false, child: _pages[_indexPage]),
      bottomNavigationBar: BottomNavigationBar(
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _indexPage = index;
          });
        },
        currentIndex: _indexPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_rounded),
            label: 'Daftar Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Grafik',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
