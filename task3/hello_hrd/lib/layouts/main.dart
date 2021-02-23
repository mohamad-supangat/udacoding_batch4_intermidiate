import 'package:flutter/material.dart';

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
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
              bottom: 30,
            ),
            child: child,
          ),
        )
      ],
    );
  }
}
