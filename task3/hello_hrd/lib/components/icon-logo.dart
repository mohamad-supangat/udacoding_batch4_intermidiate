import 'package:flutter/material.dart';

class IconLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(20),
      child: Icon(
        Icons.account_circle,
        color: Colors.teal,
        size: 50,
      ),
    );
  }
}
