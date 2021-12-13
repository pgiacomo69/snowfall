import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflakes_painter.dart';
import 'package:snowfall/snowfall/snowflake_model.dart';
import 'package:snowfall/snowfall/snowfall_rendering.dart';

class Snowflakes extends StatefulWidget {
  final int numberOfSnowflakes;
  final Color color;
  final int alpha;
  const Snowflakes(
      {required this.numberOfSnowflakes,
      required this.color,
      required this.alpha,
      Key? key})
      : super(key: key);

  @override
  _SnowflakesState createState() => _SnowflakesState();
}

class _SnowflakesState extends State<Snowflakes> {
  final Random random = Random();

  final List<SnowflakeModel> flakes = [];

  @override
  void initState() {
    List.generate(widget.numberOfSnowflakes, (index) {
      flakes.add(SnowflakeModel(random));
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

  _simulateFlakes(Duration time) {
    for (var flake in flakes) {
      flake.maintainRestart(time);
    }
  }
}
