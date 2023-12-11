import 'package:control_loop_test/sim/ball.dart';
import 'package:test/test.dart';

void main() {
  group('Ball update', () {
    late Ball ball;
    const updateDuration = Duration(seconds: 1);

    setUp(() {
      ball = Ball(position: 0, velocity: 0);
    });

    test(
        'Given ball with no force '
        'When update is called '
        'Then should not change position or velocity', () {
      ball.update(0, updateDuration);

      expect(ball.position, 0);
      expect(ball.velocity, 0);
    });

    test(
        'Given ball with positive force '
        'When update is called '
        'Then should increase velocity and position', () {
      ball.update(10, updateDuration);

      expect(ball.position, 10);
      expect(ball.velocity, 10);
    });

    test(
        'Given ball with negative force '
        'When update is called '
        'Then should decrease velocity and position', () {
      ball.update(-5, updateDuration);

      expect(ball.position, -5);
      expect(ball.velocity, -5);
    });
  });

  group('Ball reset', () {
    test('should reset position and velocity to 0', () {
      final ball = Ball(position: 10, velocity: 5)..reset();

      expect(ball.position, 0);
      expect(ball.velocity, 0);
    });
  });
}
