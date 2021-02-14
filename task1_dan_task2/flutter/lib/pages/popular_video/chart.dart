import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/popular_videos_chart_bloc.dart';
import '../../components/no_items.dart';

class ChartPopularVideos extends StatefulWidget {
  @override
  _ChartPopularVideosState createState() => _ChartPopularVideosState();
}

class _ChartPopularVideosState extends State<ChartPopularVideos> {
  final PopularVideosChartBloc popularVideosChartBloc =
      PopularVideosChartBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Grafik video',
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
          'Disini kamu bisa melihat data statik popularitas dari setiap video populer',
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
        BlocProvider<PopularVideosChartBloc>(
          create: (context) =>
              popularVideosChartBloc..add(GetPopularVideosChart()),
          child: BlocBuilder<PopularVideosChartBloc, PopularVideosChartState>(
              builder: (context, state) {
            if (state is PopularVideosChartLoaded) {
              if (state.chartData.length == 0) {
                return NoItems(
                  message: 'Tidak ada data tersedia',
                  color: Colors.white,
                );
              }

              return Expanded(
                child: charts.BarChart(
                  state.chartData,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  domainAxis: new charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelRotation: 90,
                    ),
                  ),
                ),
              );
            } else if (state is PopularVideosChartInitial) {
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
