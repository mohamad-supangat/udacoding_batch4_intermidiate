import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/popular_video.dart';
import '../helpers/api.dart';

// bloc
class FavoriteVideosBloc
    extends Bloc<FavoriteVideosEvent, FavoriteVideosState> {
  FavoriteVideosBloc() : super(FavoriteVideosInitial());

  FavoriteVideosState get initialState => FavoriteVideosInitial();

  @override
  Stream<FavoriteVideosState> mapEventToState(
    FavoriteVideosEvent event,
  ) async* {
    if (event is GetFavoriteVideos) {
      yield* getFavoriteVideos();
    }
  }

  Stream<FavoriteVideosState> getFavoriteVideos() async* {
    try {
      final response = await callApi().get('/favorite/list');

      List<PopularVideo> favoriteVideos =
          popularVideosFromJson(response.data['data']['favorites']);
      yield FavoriteVideosLoaded(favoriteVideos);
    } catch (e) {
      print(e);
      yield FavoriteVideosError();
    }
  }
}

// state of flutter bloc
abstract class FavoriteVideosState extends Equatable {
  const FavoriteVideosState();

  @override
  List<Object> get props => [];
}

class FavoriteVideosInitial extends FavoriteVideosState {}

class FavoriteVideosLoaded extends FavoriteVideosState {
  final List<PopularVideo> favoriteVideos;

  FavoriteVideosLoaded(this.favoriteVideos);

  @override
  List<Object> get props => [favoriteVideos];
}

class FavoriteVideosError extends FavoriteVideosState {}

// event of flutter bloc
abstract class FavoriteVideosEvent extends Equatable {
  const FavoriteVideosEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteVideos extends FavoriteVideosEvent {}

class RefreshFavoriteVideos extends FavoriteVideosEvent {}
