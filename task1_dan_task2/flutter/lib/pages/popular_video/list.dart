import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/bloc.dart';
import 'detail.dart';
import '../../components/no_items.dart';

class ListPopularVideos extends StatefulWidget {
  @override
  _ListPopularVideosState createState() => _ListPopularVideosState();
}

class _ListPopularVideosState extends State<ListPopularVideos> {
  final PopularVideosBloc _popularVideosBloc = PopularVideosBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'List video populer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Daftar video youtube populer di Indonesia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30,
        ),
        BlocProvider<PopularVideosBloc>(
          create: (context) => _popularVideosBloc..add(GetPopularVideos()),
          child: BlocBuilder<PopularVideosBloc, PopularVideosState>(
              builder: (context, state) {
            if (state is PopularVideosLoaded) {
              return Expanded(
                child: ListView(
                  children: state.popularVideos
                      .map<Widget>(
                        (video) => Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailVideo(video),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.grey[300],
                                  width: double.infinity,
                                  height: 150,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(video.thumbnailUrl),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        video.title,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            } else if (state is PopularVideosInitial) {
              return Expanded(
                child: Shimmer.fromColors(
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
      ],
    );
  }
}
