import 'package:control_loop_test/process.dart';

class PIDController {
  // Previous error

  PIDController({required this.kp, required this.ki, required this.kd})
      : _setpoint = 0,
        _integralTerm = 0,
        _previousError = 0;

  double kp; // Proportional gain
  double ki; // Integral gain
  double kd; // Derivative gain

  double _setpoint; // Desired setpoint
  double _integralTerm; // Integral term
  double _previousError;

  double calculate(double input) {
    final double error = _setpoint - input;

    // Proportional term
    final double proportionalTerm = kp * error;

    // Integral term
    _integralTerm += ki * error;

    // Derivative term
    final double derivativeTerm = kd * (error - _previousError);

    // Calculate the output
    final double output = proportionalTerm + _integralTerm + derivativeTerm;

    // Update the previous error
    _previousError = error;

    return output;
  }

  void control(Process process, Duration timeStep) {
    final double output = calculate(process.currentValue);
    process.setCurrentOutput(output);
  }

  void setSetpoint(double setpoint) {
    _setpoint = setpoint;
    _integralTerm = 0;
    _previousError = 0;
  }

  void reset() {
    _setpoint = 0;
    _integralTerm = 0;
    _previousError = 0;
  }
}
