import 'package:control_loop_test/sim/tube.dart';

class TubeSimulation {
  TubeSimulation({
    required Tube tube,
  })  : _time = Duration.zero,
        _tube = tube;

  final Tube _tube;
  Duration _time;

  void update(Duration timeStep) {
    _tube.update(timeStep);
    _time += timeStep;
  }

  void reset() {
    _time = Duration.zero;
    _tube.reset();
  }

  Duration get time => _time;
  double get position => _tube.ball.position;
  double get velocity => _tube.ball.velocity;
  double get orientationDegrees => _tube.orientationDegrees;
  double get length => _tube.length;
  set orientationDegrees(double value) => _tube.orientationDegrees = value;
}
