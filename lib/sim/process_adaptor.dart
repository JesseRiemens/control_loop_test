import 'package:control_loop_test/process.dart';
import 'package:control_loop_test/sim/tube_simulation.dart';

class TubeSimProcessAdaptor implements Process {
  TubeSimProcessAdaptor(this._tubeSimulation);

  final TubeSimulation _tubeSimulation;

  @override
  double get currentValue => _tubeSimulation.position;

  @override
  void setCurrentOutput(double output) {
    _tubeSimulation.orientationDegrees = output.clamp(-180, 180);
  }
}
