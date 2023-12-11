import 'package:control_loop_test/sim/ball.dart';
import 'package:control_loop_test/sim/simulation.dart';
import 'package:control_loop_test/sim/tube.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'simulation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Tube>(), MockSpec<Ball>()])
void main() {
  test('Simulation should update tube', () {
    final mockTube = MockTube();

    const timeStep = 0.1;

    Simulation(
      timeStep: timeStep,
      tube: mockTube,
    ).update();

    verify(mockTube.update(timeStep)).called(1);
  });

  test('Simulation should reset tube', () {
    final mockTube = MockTube();

    Simulation(
      timeStep: 0.1,
      tube: mockTube,
    ).reset();

    verify(mockTube.reset()).called(1);
  });

  test('Simulation should return time', () {
    final mockTube = MockTube();

    final simulation = Simulation(
      timeStep: 0.1,
      tube: mockTube,
    );

    expect(simulation.time, 0);
  });

  test('Simulation should return position', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    when(mockTube.ball).thenReturn(mockBall);

    final simulation = Simulation(
      timeStep: 0.1,
      tube: mockTube,
    );

    when(mockBall.position).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.position, 1);
  });

  test('Simulation should return velocity', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    final simulation = Simulation(
      timeStep: 0.1,
      tube: mockTube,
    );

    when(mockBall.velocity).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.velocity, 1);
  });

  test('Simulation should return orientation', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    final simulation = Simulation(
      timeStep: 0.1,
      tube: mockTube,
    );

    when(mockTube.orientationDegrees).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.orientationDegrees, 1);
  });

  test('When tube is updated, time should increase', () {
    final mockTube = MockTube();

    final simulation = Simulation(
      timeStep: 0.1,
      tube: mockTube,
    )..update();

    expect(simulation.time, 0.1);
  });
}
