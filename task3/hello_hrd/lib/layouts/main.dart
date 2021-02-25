import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  MainLayout({
    @required this.child,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    if (this.scrollable) {
      return SingleChildScrollView(
        child: _mainWidget(context),
      );
    } else {
      return _mainWidget(context);
    }
  }

  Widget _mainWidget(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: SinCosineWaveClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal,
                  Colors.teal,
                  Colors.teal[300],
                  Colors.teal[800],
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.03,
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
