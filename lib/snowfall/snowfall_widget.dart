import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflakes.dart';

class SnowfallWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final int numberOfSnowflakes;
  final int alpha;
  const SnowfallWidget(
      {Key? key,
      required this.child,
      this.numberOfSnowflakes = 30,
      this.color = Colors.white,
      this.alpha = 180})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
              child: Snowflakes(
                  numberOfSnowflakes: numberOfSnowflakes,
                  color: color,
                  alpha: alpha)),
          Positioned.fill(child: child),
        ],
      );
}
