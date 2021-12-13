import 'package:flutter/material.dart';
import 'package:snowfall/snowfall/snowflake_model.dart';

class SnowflakesPainter extends CustomPainter {
  List<SnowflakeModel> snowflakes;
  Duration time;
  Color color;
  int alpha;
  SnowflakesPainter({required this.snowflakes, required this.time, required this.color, required this.alpha});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color.withAlpha(alpha)
      ..style = PaintingStyle.fill;
    for (var snowflake in snowflakes) {
      var progress = snowflake.animationProgress!.progress(time);
      final animation = snowflake.tween!.transform(progress);
      final position =
          Offset(animation.get(AniProps.X) * size.width, animation.get(AniProps.Y) * size.height);
      canvas.drawPath(snowflake.path!.shift(position), p);

    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}