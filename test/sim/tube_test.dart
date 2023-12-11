import 'dart:math';

import 'package:control_loop_test/sim/ball.dart';
import 'package:control_loop_test/sim/tube.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'tube_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Ball>()])
void main() {
  group('Tube General calls', () {
    late Tube tube;
    late MockBall mockBall;

    setUp(() {
      mockBall = MockBall();
      tube = Tube(ball: mockBall, length: 10, orientationDegrees: 45);
    });

    test('should update ball', () {
      tube.update(0.1);

      verify(mockBall.update(any, 0.1)).called(1);
    });

    test('should reset ball', () {
      tube.reset();

      verify(mockBall.reset()).called(1);
    });

    test('should return orientation', () {
      expect(tube.orientationDegrees, 45);
    });

    test('should return length', () {
      expect(tube.length, 10);
    });
  });

  group('Tube update', () {
    late Tube tube;
    late MockBall mockBall;

    setUp(() {
      mockBall = MockBall();
      tube = Tube(ball: mockBall, length: 10, orientationDegrees: 45);
    });

    test(
        'Given tube is horizontal '
        'When update is called '
        'Then should update ball with force 0', () {
      tube
        ..orientationDegrees = 0
        ..update(0.1);

      verify(mockBall.update(0, 0.1)).called(1);
    });

    test(
        'Given tube is vertical '
        'When update is called '
        'Then should update ball with force gravity', () {
      tube
        ..orientationDegrees = 90
        ..update(0.1);

      verify(mockBall.update(9.81, 0.1)).called(1);
    });

    test(
        'Given tube is vertical to the left '
        'When update is called '
        'Then should update ball with force gravity', () {
      tube
        ..orientationDegrees = -90
        ..update(0.1);

      verify(mockBall.update(-9.81, 0.1)).called(1);
    });

    test(
        'Given tube is 45 degrees '
        'When update is called '
        'Then should update ball with force gravity * sin(45)', () {
      tube.update(0.1);

      verify(mockBall.update(9.81 * sin(45 * pi / 180), 0.1)).called(1);
    });

    test(
        'Given tube is -45 degrees '
        'When update is called '
        'Then should update ball with force gravity * sin(-45)', () {
      tube
        ..orientationDegrees = -45
        ..update(0.1);

      verify(mockBall.update(9.81 * sin(-45 * pi / 180), 0.1)).called(1);
    });

    test(
        'Given tube is at 0 position '
        'When update is called with -45 degrees '
        'Then should update ball and then should reset to 0,0', () {
      tube
        ..orientationDegrees = -45
        ..update(0.1);

      verify(mockBall.update(9.81 * sin(-45 * pi / 180), 0.1)).called(1);

      expect(tube.ball.position, 0);
      expect(tube.ball.velocity, 0);
    });
  });
}
