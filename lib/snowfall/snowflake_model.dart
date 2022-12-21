import 'dart:math' as math;

import 'package:breeze_app/ui/widgets/stateless/snowfall/utils/point.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

enum AniProps { X, Y }

class AnimationProgress {
  /// Creates an [AnimationProgress].
  const AnimationProgress({required this.duration, required this.startTime});

  final Duration duration;
  final Duration startTime;

  /// Queries the current progress value based on the specified [startTime] and
  /// [duration] as a value between `0.0` and `1.0`. It will automatically
  /// clamp values this interval to fit in.
  double progress(Duration time) => math.max(0,
      math.min((time - startTime).inMilliseconds / duration.inMilliseconds, 1));
}

class SnowflakeModel {
  SnowflakeModel(this.random,
      {required this.minSize,
      required this.maxSize,
      required this.applyRandomRotation,
      this.pathOverrideBuilder})
      : assert(maxSize >= minSize) {
    restart();
  }
  static Map<int, Path> cachedFlakes = {};

  final math.Random random;
  final double minSize;
  final double maxSize;
  final Path Function(double size)? pathOverrideBuilder;
  final bool applyRandomRotation;
  Animatable? tween;
  double size = 0;
  AnimationProgress? animationProgress;
  Path? _path;

  void restart({Duration time = Duration.zero}) {
    _path = null;
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -0.2);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.2);
    final duration = Duration(seconds: 5, milliseconds: random.nextInt(10000));
    tween = MultiTween<AniProps>()
      ..add(AniProps.X, Tween(begin: startPosition.dx, end: endPosition.dx),
          duration, Curves.easeInOutSine)
      ..add(AniProps.Y, Tween(begin: startPosition.dy, end: endPosition.dy),
          duration, Curves.easeIn);

    /* tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]); */
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = minSize + random.nextDouble() * (maxSize - minSize);
    drawPath();
  }

  void drawPath() {
    if (_path != null) {
      return;
    }
    double sideLength = maxSize - minSize;

    int iterationsTotal = 1;
    // we calculate the total number of iterations
    // based on the snowflake's size
    if (size > 40) {
      iterationsTotal += size ~/ 25;
    }
    _path = Path();
    if (pathOverrideBuilder != null) {
      _path = pathOverrideBuilder!(size);
    } else if (cachedFlakes[iterationsTotal] == null) {
      final double down = (sideLength / 2) * math.tan(math.pi / 6);
      final double up = (sideLength / 2) * math.tan(math.pi / 3) - down;
      Point p1 = Point(-sideLength / 2, down);
      Point p2 = Point(sideLength / 2, down);
      Point p3 = Point(0, -up);
      Point p4 = Point(0, 0);
      Point p5 = Point(0, 0);
      double rot = random.nextDouble() * 6.28319;
      List<Point> lines = <Point>[p1, p2, p3];
      List<Point> tmpLines = <Point>[];

      for (int iterations = 0; iterations < iterationsTotal; iterations++) {
        sideLength /= 3;
        for (int loop = 0; loop < lines.length; loop++) {
          p1 = lines[loop];
          if (loop == lines.length - 1) {
            p2 = lines[0];
          } else {
            p2 = lines[loop + 1];
          }
          rot = math.atan2(p2.y - p1.y, p2.x - p1.x);
          p3 = p1 + Point.polar(sideLength, rot);
          rot += math.pi / 3;
          p4 = p3 + Point.polar(sideLength, rot);
          rot -= 2 * math.pi / 3;
          p5 = p4 + Point.polar(sideLength, rot);
          tmpLines.add(p1);
          tmpLines.add(p3);
          tmpLines.add(p4);
          tmpLines.add(p5);
        }
        lines = tmpLines;
        tmpLines = <Point>[];
      }
      lines.add(p2);
      _path!.moveTo(lines[0].x, lines[0].y);
      for (int a = 0; a < lines.length; a++) {
        _path!.lineTo(lines[a].x, lines[a].y);
      }
      _path!.lineTo(lines[0].x, lines[0].y);
      cachedFlakes[iterationsTotal] = _path!;
    } else {
      _path = cachedFlakes[iterationsTotal];
    }
    // early return when no random z axis rotation needs
    // to be applied
    if (!applyRandomRotation) return;
    final Matrix4 m = Matrix4.identity();
    // the rotation must be in radians
    // and to get a random angle we use the 360 equivalent
    // in radians that is 6.28319
    m.setRotationZ(random.nextDouble() * 6.28319);
    final num scaleTo = size / sideLength;
    m.scale(scaleTo);
    final List<double> list = m.storage.toList();
    _path = _path!.transform(Float64List.fromList(list));
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
