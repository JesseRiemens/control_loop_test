import 'package:control_loop_test/sim/tube.dart';

class Simulation {
  Simulation({
    required double timeStep,
    required Tube tube,
  })  : _timeStep = timeStep,
        _time = 0,
        _tube = tube;

  final double _timeStep;
  final Tube _tube;
  double _time;

  void update() {
    _tube.update(_timeStep);
    _time += _timeStep;
  }

  void reset() {
    _time = 0;
    _tube.reset();
  }

  double get time => _time;
  double get position => _tube.ball.position;
  double get velocity => _tube.ball.velocity;
  double get orientationDegrees => _tube.orientationDegrees;
}
