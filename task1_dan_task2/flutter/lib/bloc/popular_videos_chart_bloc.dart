import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../helpers/api.dart';

// bloc
class PopularVideosChartBloc
    extends Bloc<PopularVideosChartEvent, PopularVideosChartState> {
  PopularVideosChartBloc() : super(PopularVideosChartInitial());

  PopularVideosChartState get initialState => PopularVideosChartInitial();

  @override
  Stream<PopularVideosChartState> mapEventToState(
    PopularVideosChartEvent event,
  ) async* {
    if (event is GetPopularVideosChart) {
      yield* getPopularVideosChart();
    }
  }

  Stream<PopularVideosChartState> getPopularVideosChart() async* {
    try {
      final response = await callApi().get('/youtube/populars/chart');
      print('hahahaha');
      print(response.data);
      List<VideoStatistic> viewsData = response.data['data']['populars']
          .map((video) => VideoStatistic(video['title'], video['view'].toInt()))
          .toList();
      List<VideoStatistic> likesData = response.data['data']['populars']
          .map((video) => VideoStatistic(video['title'], video['like'].toInt()))
          .toList();

      List<VideoStatistic> unlikesData = response.data['data']['populars']
          .map((video) =>
              VideoStatistic(video['title'], video['unlike'].toInt()))
          .toList();
      List<VideoStatistic> commentsData = response.data['data']['populars'].map(
          (video) => VideoStatistic(video['title'], video['comment'].toInt()));

      final _chartData = [
        new charts.Series<VideoStatistic, String>(
          id: 'View',
          domainFn: (VideoStatistic statistic, _) => statistic.title,
          measureFn: (VideoStatistic statistic, _) => statistic.count,
          data: viewsData,
        ),
        new charts.Series<VideoStatistic, String>(
          id: 'Like',
          domainFn: (VideoStatistic statistic, _) => statistic.title,
          measureFn: (VideoStatistic statistic, _) => statistic.count,
          data: likesData,
        ),
        new charts.Series<VideoStatistic, String>(
          id: 'Dislike',
          domainFn: (VideoStatistic statistic, _) => statistic.title,
          measureFn: (VideoStatistic statistic, _) => statistic.count,
          data: unlikesData,
        ),
        new charts.Series<VideoStatistic, String>(
          id: 'Comment',
          domainFn: (VideoStatistic statistic, _) => statistic.title,
          measureFn: (VideoStatistic statistic, _) => statistic.count,
          data: unlikesData,
        ),
      ];

      yield PopularVideosChartLoaded(_chartData);
    } catch (e) {
      print(e);
      yield PopularVideosChartError();
    }
  }
}

// state of flutter bloc
abstract class PopularVideosChartState extends Equatable {
  const PopularVideosChartState();

  @override
  List<Object> get props => [];
}

class PopularVideosChartInitial extends PopularVideosChartState {}

class PopularVideosChartLoaded extends PopularVideosChartState {
  final List<charts.Series<VideoStatistic, String>> chartData;

  PopularVideosChartLoaded(this.chartData);

  @override
  List<Object> get props => [chartData];
}

class PopularVideosChartError extends PopularVideosChartState {}

// event of flutter bloc
abstract class PopularVideosChartEvent extends Equatable {
  const PopularVideosChartEvent();

  @override
  List<Object> get props => [];
}

class GetPopularVideosChart extends PopularVideosChartEvent {}

class RefreshPopularVideosChart extends PopularVideosChartEvent {}

// class video statistic
class VideoStatistic {
  final String title;
  final int count;

  VideoStatistic(this.title, this.count);
}
