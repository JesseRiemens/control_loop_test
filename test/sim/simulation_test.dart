import 'package:control_loop_test/sim/ball.dart';
import 'package:control_loop_test/sim/tube.dart';
import 'package:control_loop_test/sim/tube_simulation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'simulation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Tube>(), MockSpec<Ball>()])
const timeStep = Duration(milliseconds: 100);
void main() {
  test('Simulation should update tube', () {
    final mockTube = MockTube();

    TubeSimulation(
      tube: mockTube,
    ).update(timeStep);

    verify(mockTube.update(timeStep)).called(1);
  });

  test('Simulation should reset tube', () {
    final mockTube = MockTube();

    TubeSimulation(
      tube: mockTube,
    ).reset();

    verify(mockTube.reset()).called(1);
  });

  test('Simulation should return time', () {
    final mockTube = MockTube();

    final simulation = TubeSimulation(
      tube: mockTube,
    );

    expect(simulation.time, Duration.zero);
  });

  test('Simulation should return position', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    when(mockTube.ball).thenReturn(mockBall);

    final simulation = TubeSimulation(
      tube: mockTube,
    );

    when(mockBall.position).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.position, 1);
  });

  test('Simulation should return velocity', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    final simulation = TubeSimulation(
      tube: mockTube,
    );

    when(mockBall.velocity).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.velocity, 1);
  });

  test('Simulation should return orientation', () {
    final mockTube = MockTube();
    final mockBall = MockBall();

    final simulation = TubeSimulation(
      tube: mockTube,
    );

    when(mockTube.orientationDegrees).thenReturn(1);
    when(mockTube.ball).thenReturn(mockBall);

    expect(simulation.orientationDegrees, 1);
  });

  test('When tube is updated, time should increase', () {
    final mockTube = MockTube();

    final simulation = TubeSimulation(
      tube: mockTube,
    )..update(timeStep);

    expect(simulation.time, timeStep);
  });
}
