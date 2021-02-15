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

      List<VideoStatistic> viewsData = List<VideoStatistic>.from(
        response.data['data']['populars'].map((video) =>
            VideoStatistic(video['title'], int.parse(video['view']))),
      );

      List<VideoStatistic> likesData = List<VideoStatistic>.from(
        response.data['data']['populars'].map((video) =>
            VideoStatistic(video['title'], int.parse(video['like']))),
      );

      List<VideoStatistic> unlikesData = List<VideoStatistic>.from(
        response.data['data']['populars'].map((video) =>
            VideoStatistic(video['title'], int.parse(video['dislike']))),
      );

      final _chartData = {
        'view': [
          new charts.Series<VideoStatistic, String>(
            id: 'View',
            domainFn: (VideoStatistic statistic, _) =>
                statistic.title.substring(0, 10),
            measureFn: (VideoStatistic statistic, _) => statistic.count,
            data: viewsData,
          ),
        ],
        'like': [
          new charts.Series<VideoStatistic, String>(
            id: 'View',
            domainFn: (VideoStatistic statistic, _) =>
                statistic.title.substring(0, 10),
            measureFn: (VideoStatistic statistic, _) => statistic.count,
            data: likesData,
            fillColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          ),
        ],
        'dislike': [
          new charts.Series<VideoStatistic, String>(
            id: 'View',
            domainFn: (VideoStatistic statistic, _) =>
                statistic.title.substring(0, 10),
            measureFn: (VideoStatistic statistic, _) => statistic.count,
            data: unlikesData,
            fillColorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          ),
        ]
      };

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
  final Map<String, List<charts.Series<VideoStatistic, String>>> chartData;

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
