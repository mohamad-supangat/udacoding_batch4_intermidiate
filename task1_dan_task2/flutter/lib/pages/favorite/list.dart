import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/favorite_videos_bloc.dart';
import '../popular_video/detail.dart';
import '../../components/no_items.dart';

class ListFavoriteVideos extends StatefulWidget {
  @override
  _ListFavoriteVideosState createState() => _ListFavoriteVideosState();
}

class _ListFavoriteVideosState extends State<ListFavoriteVideos> {
  final FavoriteVideosBloc _favoriteVideoBloc = FavoriteVideosBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'List video favorit',
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
          'Daftar semua video favorit kamu',
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
        BlocProvider<FavoriteVideosBloc>(
          create: (context) => _favoriteVideoBloc..add(GetFavoriteVideos()),
          child: BlocBuilder<FavoriteVideosBloc, FavoriteVideosState>(
              builder: (context, state) {
            if (state is FavoriteVideosLoaded) {
              if (state.favoriteVideos.length == 0) {
                return NoItems(
                  message: 'Tidak ada data tersedia',
                  color: Colors.white,
                );
              }

              return Expanded(
                child: ListView(
                  children: state.favoriteVideos
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
            } else if (state is FavoriteVideosInitial) {
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
