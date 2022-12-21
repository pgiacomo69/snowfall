import 'dart:math';

import 'package:breeze_app/ui/widgets/stateless/snowfall/snowfall_rendering.dart';
import 'package:breeze_app/ui/widgets/stateless/snowfall/snowflake_model.dart';
import 'package:breeze_app/ui/widgets/stateless/snowfall/snowflakes_painter.dart';
import 'package:flutter/material.dart';

class Snowflakes extends StatefulWidget {
  const Snowflakes(
      {required this.numberOfSnowflakes,
      required this.pathBuilder,
      required this.minSize,
      required this.maxSize,
      required this.applyRandomRotation,
      required this.color,
      required this.alpha,
      Key? key})
      : super(key: key);

  final int numberOfSnowflakes;
  final Path Function(double size)? pathBuilder;
  final double minSize;
  final double maxSize;
  final bool applyRandomRotation;
  final Color color;
  final int alpha;

  @override
  _SnowflakesState createState() => _SnowflakesState();
}

class _SnowflakesState extends State<Snowflakes> {
  final Random random = Random();

  final List<SnowflakeModel> flakes = [];

  @override
  void initState() {
    List.generate(widget.numberOfSnowflakes, (index) {
      flakes.add(SnowflakeModel(random,
          minSize: widget.minSize,
          maxSize: widget.maxSize,
          applyRandomRotation: widget.applyRandomRotation,
          pathOverrideBuilder: widget.pathBuilder));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SnowfallRendering(
      startTime: const Duration(seconds: 30),
      onTick: _simulateFlakes,
      builder: (context, time) {
        return CustomPaint(
          painter: SnowflakesPainter(
              snowflakes: flakes,
              time: time,
              color: widget.color,
              alpha: widget.alpha),
        );
      },
    );
  }

  void _simulateFlakes(Duration time) {
    for (final flake in flakes) {
      flake.maintainRestart(time);
    }
  }
}
