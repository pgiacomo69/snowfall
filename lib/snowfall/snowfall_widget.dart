import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflakes.dart';

class SnowfallWidget extends StatelessWidget {
  const SnowfallWidget(
      {Key? key,
      required this.child,
      this.snowflakePathBuilder,
      this.numberOfSnowflakes = 30,
      this.minSize = 20,
      this.maxSize = 120,
      this.applyRandomRotation = true,
      this.color = Colors.white,
      this.alpha = 180})
      : super(key: key);

  final Widget child;
  final Path Function(double size)? snowflakePathBuilder;
  final bool applyRandomRotation;
  final int numberOfSnowflakes;
  final double minSize;
  final double maxSize;
  final Color color;
  final int alpha;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned.fill(
            child: Snowflakes(
                pathBuilder: snowflakePathBuilder,
                numberOfSnowflakes: numberOfSnowflakes,
                minSize: minSize,
                maxSize: maxSize,
                applyRandomRotation: applyRandomRotation,
                color: color,
                alpha: alpha),
          ),
          Positioned.fill(child: child),
        ],
      );
}
