import 'package:flutter/material.dart';

class NoItems extends StatelessWidget {
  final String message;
  final Color color;
  NoItems({
    this.message,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.sentiment_very_dissatisfied,
            color: color,
            size: 100,
          ),
          SizedBox(
            height: 12,
          ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
