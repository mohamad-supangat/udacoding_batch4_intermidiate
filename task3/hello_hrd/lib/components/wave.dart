import 'package:wave/wave.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';

class Wave extends StatelessWidget {
  final double width;
  final double height;
  final List<Color> colors;

  Wave({
    this.width = double.infinity,
    this.height = double.infinity,
    this.colors = const [
      Colors.white70,
      Colors.white54,
      Colors.white30,
      Colors.white24,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.20, 0.23, 0.25, 0.30],
        colors: colors,
      ),
      size: Size(
        width,
        height,
      ),
    );
  }
}
