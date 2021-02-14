import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/popular_video.dart';
import '../helpers/api.dart';

// bloc
class PopularVideosBloc extends Bloc<PopularVideosEvent, PopularVideosState> {
  PopularVideosBloc() : super(PopularVideosInitial());

  PopularVideosState get initialState => PopularVideosInitial();

  @override
  Stream<PopularVideosState> mapEventToState(
    PopularVideosEvent event,
  ) async* {
    if (event is GetPopularVideos) {
      yield* getPopularVideos();
    }
  }

  Stream<PopularVideosState> getPopularVideos() async* {
    try {
      final response = await callApi().get('/youtube/populars/list');
      // print(response.data['popular']);
      List<PopularVideo> popularVideos =
          popularVideosFromJson(response.data['data']['populars']);
      yield PopularVideosLoaded(popularVideos);
    } catch (_) {
      yield PopularVideosError();
    }
  }
}

// state of flutter bloc
abstract class PopularVideosState extends Equatable {
  const PopularVideosState();

  @override
  List<Object> get props => [];
}

class PopularVideosInitial extends PopularVideosState {}

class PopularVideosLoaded extends PopularVideosState {
  final List<PopularVideo> popularVideos;

  PopularVideosLoaded(this.popularVideos);

  @override
  List<Object> get props => [popularVideos];
}

class PopularVideosError extends PopularVideosState {}

// event of flutter bloc
abstract class PopularVideosEvent extends Equatable {
  const PopularVideosEvent();

  @override
  List<Object> get props => [];
}

class GetPopularVideos extends PopularVideosEvent {}

class RefreshPopularVideos extends PopularVideosEvent {}
