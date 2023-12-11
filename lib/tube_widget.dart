import 'dart:math';

import 'package:flutter/material.dart';

class TubeDisplay extends StatelessWidget {
  const TubeDisplay({
    required this.tubeLength,
    required this.tubeHeight,
    required this.orientationDegrees,
    required this.position,
    required this.maxPosition,
    required this.velocity,
    super.key,
  });

  final double tubeLength;
  final double tubeHeight;
  final double orientationDegrees;
  final double position;
  final double maxPosition;
  final double velocity;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TubeDrawing(
            tubeLength: tubeLength,
            tubeHeight: tubeHeight,
            orientationDegrees: orientationDegrees,
            positionPercentage: position / maxPosition,
          ),
          const SizedBox(height: 50),
          Text('Tube Size: ${maxPosition.toStringAsFixed(2)}'),
          Text('Orientation: ${orientationDegrees.toStringAsFixed(2)}'),
          Text('Position: ${position.toStringAsFixed(2)}'),
          Text('Velocity: ${velocity.toStringAsFixed(2)}'),
        ],
      );
}

class TubeDrawing extends StatelessWidget {
  const TubeDrawing({
    required this.tubeLength,
    required this.tubeHeight,
    required this.orientationDegrees,
    required this.positionPercentage,
    super.key,
  });

  final double tubeLength;
  final double tubeHeight;
  final double orientationDegrees;
  final double positionPercentage;

  /// using a transformed box to draw the tube
  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: orientationDegrees * pi / 180,
        child: Stack(
          children: [
            Container(
              width: tubeLength,
              height: tubeHeight,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              // draw the ball
            ),
            Positioned(
              left: positionPercentage * (tubeLength - tubeHeight),
              child: Container(
                width: tubeHeight,
                height: tubeHeight,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      );
}
