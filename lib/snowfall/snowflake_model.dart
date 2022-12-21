import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:snowfall/snowfall/utils/point.dart';

enum AniProps { X, Y }

class AnimationProgress {
  final Duration duration;
  final Duration startTime;

  /// Creates an [AnimationProgress].
  AnimationProgress({required this.duration, required this.startTime});

  /// Queries the current progress value based on the specified [startTime] and
  /// [duration] as a value between `0.0` and `1.0`. It will automatically
  /// clamp values this interval to fit in.
  double progress(Duration time) =>
      math.max(0.0, math.min((time - startTime).inMilliseconds / duration.inMilliseconds, 1.0));
}

class SnowflakeModel {
  static Map<int, Path> cachedFlakes = {};

  Animatable? tween;
  double size = 0.0;
  AnimationProgress? animationProgress;
  math.Random random;
  Path? _path;

  SnowflakeModel(this.random) {
    restart();
  }

  void restart({Duration time = Duration.zero}) {
    _path = null;
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final duration = Duration(seconds: 5, milliseconds: random.nextInt(10000));
    tween = MultiTween<AniProps>()
      ..add(AniProps.X, Tween(begin: startPosition.dx, end: endPosition.dx), duration, Curves.easeInOutSine)
      ..add(AniProps.Y, Tween(begin: startPosition.dy, end: endPosition.dy), duration, Curves.easeIn);

    /* tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]); */
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 20 + random.nextDouble() * 100;
    drawPath();
  }

  void drawPath() {
    if (_path != null) {
      return;
    }
    _path.lineTo(size, size * 0.71);
    _path.cubicTo(size, size * 0.71, size * 0.89, size * 0.66, size * 0.89, size * 0.66);
    _path.cubicTo(size * 0.89, size * 0.66, size, size * 0.61, size, size * 0.61);
    _path.cubicTo(size, size * 0.6, size * 0.97, size * 0.53, size * 0.95, size * 0.54);
    _path.cubicTo(size * 0.95, size * 0.54, size * 0.81, size * 0.61, size * 0.81, size * 0.61);
    _path.cubicTo(size * 0.81, size * 0.61, size * 0.59, size / 2, size * 0.59, size / 2);
    _path.cubicTo(size * 0.59, size / 2, size * 0.81, size * 0.39, size * 0.81, size * 0.39);
    _path.cubicTo(size * 0.81, size * 0.39, size * 0.95, size * 0.46, size * 0.95, size * 0.46);
    _path.cubicTo(size * 0.97, size * 0.47, size, size * 0.4, size, size * 0.39);
    _path.cubicTo(size, size * 0.39, size * 0.89, size * 0.34, size * 0.89, size * 0.34);
    _path.cubicTo(size * 0.89, size * 0.34, size, size * 0.29, size, size * 0.29);
    _path.cubicTo(size * 1.02, size * 0.28, size * 0.97, size / 5, size * 0.95, size * 0.22);
    _path.cubicTo(size * 0.95, size * 0.22, size * 0.85, size * 0.28, size * 0.85, size * 0.28);
    _path.cubicTo(size * 0.85, size * 0.28, size * 0.85, size * 0.18, size * 0.85, size * 0.18);
    _path.cubicTo(size * 0.85, size * 0.16, size * 0.76, size * 0.16, size * 0.76, size * 0.18);
    _path.cubicTo(size * 0.76, size * 0.18, size * 0.76, size * 0.32, size * 0.76, size * 0.32);
    _path.cubicTo(size * 0.76, size * 0.32, size * 0.54, size * 0.43, size * 0.54, size * 0.43);
    _path.cubicTo(size * 0.54, size * 0.43, size * 0.54, size / 5, size * 0.54, size / 5);
    _path.cubicTo(size * 0.54, size / 5, size * 0.68, size * 0.14, size * 0.68, size * 0.14);
    _path.cubicTo(size * 0.7, size * 0.13, size * 0.66, size * 0.06, size * 0.64, size * 0.07);
    _path.cubicTo(size * 0.64, size * 0.07, size * 0.54, size * 0.12, size * 0.54, size * 0.12);
    _path.cubicTo(size * 0.54, size * 0.12, size * 0.54, size * 0.02, size * 0.54, size * 0.02);
    _path.cubicTo(size * 0.54, -0.01, size * 0.46, -0.01, size * 0.46, size * 0.02);
    _path.cubicTo(size * 0.46, size * 0.02, size * 0.46, size * 0.12, size * 0.46, size * 0.12);
    _path.cubicTo(size * 0.46, size * 0.12, size * 0.36, size * 0.07, size * 0.36, size * 0.07);
    _path.cubicTo(size * 0.34, size * 0.06, size * 0.3, size * 0.13, size * 0.32, size * 0.14);
    _path.cubicTo(size * 0.32, size * 0.14, size * 0.46, size / 5, size * 0.46, size / 5);
    _path.cubicTo(size * 0.46, size / 5, size * 0.46, size * 0.43, size * 0.46, size * 0.43);
    _path.cubicTo(size * 0.46, size * 0.43, size * 0.24, size * 0.32, size * 0.24, size * 0.32);
    _path.cubicTo(size * 0.24, size * 0.32, size * 0.24, size * 0.18, size * 0.24, size * 0.18);
    _path.cubicTo(size * 0.24, size * 0.16, size * 0.15, size * 0.16, size * 0.15, size * 0.18);
    _path.cubicTo(size * 0.15, size * 0.18, size * 0.15, size * 0.28, size * 0.15, size * 0.28);
    _path.cubicTo(size * 0.15, size * 0.28, size * 0.05, size * 0.22, size * 0.05, size * 0.22);
    _path.cubicTo(size * 0.03, size / 5, -0.02, size * 0.28, size * 0.01, size * 0.29);
    _path.cubicTo(size * 0.01, size * 0.29, size * 0.11, size * 0.34, size * 0.11, size * 0.34);
    _path.cubicTo(size * 0.11, size * 0.34, size * 0.01, size * 0.39, size * 0.01, size * 0.39);
    _path.cubicTo(-0.01, size * 0.4, size * 0.03, size * 0.47, size * 0.05, size * 0.46);
    _path.cubicTo(size * 0.05, size * 0.46, size * 0.19, size * 0.39, size * 0.19, size * 0.39);
    _path.cubicTo(size * 0.19, size * 0.39, size * 0.41, size / 2, size * 0.41, size / 2);
    _path.cubicTo(size * 0.41, size / 2, size * 0.19, size * 0.61, size * 0.19, size * 0.61);
    _path.cubicTo(size * 0.19, size * 0.61, size * 0.05, size * 0.54, size * 0.05, size * 0.54);
    _path.cubicTo(size * 0.03, size * 0.53, -0.01, size * 0.6, size * 0.01, size * 0.61);
    _path.cubicTo(size * 0.01, size * 0.61, size * 0.11, size * 0.66, size * 0.11, size * 0.66);
    _path.cubicTo(size * 0.11, size * 0.66, size * 0.01, size * 0.71, size * 0.01, size * 0.71);
    _path.cubicTo(-0.02, size * 0.72, size * 0.03, size * 0.79, size * 0.05, size * 0.78);
    _path.cubicTo(size * 0.05, size * 0.78, size * 0.15, size * 0.72, size * 0.15, size * 0.72);
    _path.cubicTo(size * 0.15, size * 0.72, size * 0.15, size * 0.82, size * 0.15, size * 0.82);
    _path.cubicTo(size * 0.15, size * 0.84, size * 0.24, size * 0.84, size * 0.24, size * 0.82);
    _path.cubicTo(size * 0.24, size * 0.82, size * 0.24, size * 0.68, size * 0.24, size * 0.68);
    _path.cubicTo(size * 0.24, size * 0.68, size * 0.46, size * 0.57, size * 0.46, size * 0.57);
    _path.cubicTo(size * 0.46, size * 0.57, size * 0.46, size * 0.79, size * 0.46, size * 0.79);
    _path.cubicTo(size * 0.46, size * 0.79, size * 0.32, size * 0.86, size * 0.32, size * 0.86);
    _path.cubicTo(size * 0.3, size * 0.87, size * 0.34, size * 0.94, size * 0.36, size * 0.93);
    _path.cubicTo(size * 0.36, size * 0.93, size * 0.46, size * 0.88, size * 0.46, size * 0.88);
    _path.cubicTo(size * 0.46, size * 0.88, size * 0.46, size * 0.98, size * 0.46, size * 0.98);
    _path.cubicTo(size * 0.46, size, size * 0.54, size, size * 0.54, size * 0.98);
    _path.cubicTo(size * 0.54, size * 0.98, size * 0.54, size * 0.88, size * 0.54, size * 0.88);
    _path.cubicTo(size * 0.54, size * 0.88, size * 0.64, size * 0.93, size * 0.64, size * 0.93);
    _path.cubicTo(size * 0.66, size * 0.94, size * 0.7, size * 0.87, size * 0.68, size * 0.86);
    _path.cubicTo(size * 0.68, size * 0.86, size * 0.54, size * 0.79, size * 0.54, size * 0.79);
    _path.cubicTo(size * 0.54, size * 0.79, size * 0.54, size * 0.57, size * 0.54, size * 0.57);
    _path.cubicTo(size * 0.54, size * 0.57, size * 0.76, size * 0.68, size * 0.76, size * 0.68);
    _path.cubicTo(size * 0.76, size * 0.68, size * 0.76, size * 0.82, size * 0.76, size * 0.82);
    _path.cubicTo(size * 0.76, size * 0.84, size * 0.85, size * 0.84, size * 0.85, size * 0.82);
    _path.cubicTo(size * 0.85, size * 0.82, size * 0.85, size * 0.72, size * 0.85, size * 0.72);
    _path.cubicTo(size * 0.85, size * 0.72, size * 0.95, size * 0.78, size * 0.95, size * 0.78);
    _path.cubicTo(size * 0.97, size * 0.79, size * 1.02, size * 0.72, size, size * 0.71);
    _path.cubicTo(size, size * 0.71, size, size * 0.71, size, size * 0.71);
  }

  Path? get path {
    if (_path != null) {
      return _path;
    }
    drawPath();
    return _path;
  }

  void maintainRestart(Duration time) {
    if (animationProgress!.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}
