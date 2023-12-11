import 'dart:async';

import 'package:control_loop_test/controller/pid_controller.dart';
import 'package:control_loop_test/sim/ball.dart';
import 'package:control_loop_test/sim/process_adaptor.dart';
import 'package:control_loop_test/sim/tube.dart';
import 'package:control_loop_test/sim/tube_simulation.dart';
import 'package:control_loop_test/tube_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    _simulation = TubeSimulation(
      tube: Tube(
        ball: Ball(
          mass: 0.1,
          position: 0,
          velocity: 0,
        ),
        length: 10,
        orientationDegrees: 0,
      ),
    );
    _controller = PIDController(
      kp: 0.1,
      ki: 0.01,
      kd: 0.01,
    );
  }

  @override
  void initState() {
    _onStartSimulation();
    _onStartController();
    super.initState();
  }

  @override
  void dispose() {
    _onStopSimulation();
    _onStopController();
    super.dispose();
  }

  late TubeSimulation _simulation;
  late PIDController _controller;
  Timer? _simTimer;
  Timer? _controllerTimer;
  bool _manual = false;

  static const _simTimeStep = Duration(milliseconds: 10);
  static const _controllerTimeStep = Duration(milliseconds: 100);

  void _handleSimTimer(Timer timer) {
    setState(() => _simulation.update(_simTimeStep));
  }

  void _handleControllerTimer(Timer timer) {
    setState(
      () => _controller.control(
        TubeSimProcessAdaptor(_simulation),
        _controllerTimeStep,
      ),
    );
  }

  void _handleRotateLeft() {
    setState(() => _simulation.orientationDegrees -= 1);
  }

  void _handleRotateRight() {
    setState(() => _simulation.orientationDegrees += 1);
  }

  void _onStartSimulation() {
    setState(() {
      _simTimer ??= Timer.periodic(
        _simTimeStep,
        _handleSimTimer,
      );
    });
  }

  void _onStopSimulation() {
    setState(() {
      _simTimer?.cancel();
      _simTimer = null;
    });
  }

  void _onStartController() {
    setState(() {
      _manual = false;
      _controller.reset();
      _controllerTimer ??= Timer.periodic(
        _controllerTimeStep,
        _handleControllerTimer,
      );
    });
  }

  void _onStopController() {
    setState(() {
      _manual = true;
      _controllerTimer?.cancel();
      _controllerTimer = null;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TubeDisplay(
                tubeLength: 150,
                tubeHeight: 15,
                orientationDegrees: _simulation.orientationDegrees,
                position: _simulation.position,
                maxPosition: _simulation.length,
                velocity: _simulation.velocity,
              ),
              Text("Time: ${_simulation.time}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Kp: ${_controller.kp.toStringAsFixed(3)}'),
                  Text('Ki: ${_controller.ki.toStringAsFixed(3)}'),
                  Text('Kd: ${_controller.kd.toStringAsFixed(3)}'),
                ],
              ),
              if (_manual)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _handleRotateLeft,
                      child: const Text('Rotate Left'),
                    ),
                    TextButton(
                      onPressed: _handleRotateRight,
                      child: const Text('Rotate Right'),
                    ),
                    TextButton(
                      onPressed: _onStartSimulation,
                      child: const Text('Start Simulation'),
                    ),
                    TextButton(
                      onPressed: _onStopSimulation,
                      child: const Text('Stop Simulation'),
                    ),
                    TextButton(
                      onPressed: _onStartController,
                      child: const Text('Start Controller'),
                    ),
                  ],
                )
              else
                TextButton(
                  onPressed: _onStopController,
                  child: const Text('Stop Controller'),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => _controller.kp += 0.1,
                    child: const Text('Increase Kp'),
                  ),
                  TextButton(
                    onPressed: () => _controller.kp -= 0.1,
                    child: const Text('Decrease Kp'),
                  ),
                  TextButton(
                    onPressed: () => _controller.ki += 0.01,
                    child: const Text('Increase Ki'),
                  ),
                  TextButton(
                    onPressed: () => _controller.ki -= 0.01,
                    child: const Text('Decrease Ki'),
                  ),
                  TextButton(
                    onPressed: () => _controller.kd += 0.01,
                    child: const Text('Increase Kd'),
                  ),
                  TextButton(
                    onPressed: () => _controller.kd -= 0.01,
                    child: const Text('Decrease Kd'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Setpoint',
                      constraints: BoxConstraints(maxWidth: 100),
                    ),
                    onChanged: (value) =>
                        _controller.setSetpoint(double.parse(value)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
