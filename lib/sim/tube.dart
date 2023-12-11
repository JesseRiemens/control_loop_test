import 'dart:math';

import 'package:control_loop_test/sim/ball.dart';

class Tube {
  Tube({
    required this.ball,
    required this.length,
    required this.orientationDegrees,
  });

  final Ball ball;
  final double length;
  double orientationDegrees;

  /// Calculates sideways part of gravity force.
  /// Positive force means ball is pushed to the right.
  void update(double timeStep) {
    const gravity = 9.81;
    final force = gravity * sin(orientationDegrees * pi / 180);

    ball.update(force, timeStep);
    if (ball.position < 0) {
      ball
        ..position = 0
        ..velocity = 0;
    } else if (ball.position > length) {
      ball
        ..position = length
        ..velocity = 0;
    }
  }

  void reset() {
    orientationDegrees = 0;
    ball.reset();
  }
}
