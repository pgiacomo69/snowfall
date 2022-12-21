import 'package:breeze_app/ui/widgets/stateless/snowfall/snowflake_model.dart';
import 'package:flutter/material.dart';

class SnowflakesPainter extends CustomPainter {
  const SnowflakesPainter(
      {required this.snowflakes,
      required this.time,
      required this.color,
      required this.alpha});

  final List<SnowflakeModel> snowflakes;
  final Duration time;
  final Color color;
  final int alpha;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color.withAlpha(alpha)
      ..style = PaintingStyle.fill;
    for (final snowflake in snowflakes) {
      final progress = snowflake.animationProgress!.progress(time);
      final animation = snowflake.tween!.transform(progress);
      final position = Offset(animation.get(AniProps.X) * size.width,
          animation.get(AniProps.Y) * size.height);
      canvas.drawPath(snowflake.path!.shift(position), p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
