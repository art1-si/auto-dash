import 'package:auto_dash/presentation/features/speedometer/models/speed.dart';
import 'package:auto_dash/presentation/features/speedometer/models/speed_metric.dart';
import 'package:flutter/material.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({
    super.key,
    required this.speed,
    this.speedMetric = SpeedMetric.kmPerHour,
  });

  final Speed speed;
  final SpeedMetric speedMetric;

  String get speedText {
    switch (speedMetric) {
      case SpeedMetric.kmPerHour:
        return '${speed.kilometersPerHour}';
      case SpeedMetric.milesPerHour:
        return '${speed.milesPerHour}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            height: constraints.maxWidth * 0.5,
            width: constraints.maxWidth * 0.5,
            child: Center(
              child: Text(
                speedText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
