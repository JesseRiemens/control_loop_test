class Ball {
  Ball({
    required this.position,
    required this.velocity,
    this.mass = 1,
  });

  double position;
  double velocity;
  double mass;

  void update(double force, Duration timeStep) {
    velocity += force / mass * timeStep.inMicroseconds / 1000000;
    position += velocity * timeStep.inMicroseconds / 1000000;
  }

  void reset() {
    position = 0;
    velocity = 0;
  }
}
