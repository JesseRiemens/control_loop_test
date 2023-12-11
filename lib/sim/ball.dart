class Ball {
  Ball({
    required this.position,
    required this.velocity,
    this.mass = 1,
  });

  double position;
  double velocity;
  double mass;

  void update(double force, double timeStep) {
    velocity += force / mass * timeStep;
    position += velocity * timeStep;
  }

  void reset() {
    position = 0;
    velocity = 0;
  }
}
