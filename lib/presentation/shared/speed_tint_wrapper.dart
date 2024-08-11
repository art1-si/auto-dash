import 'package:auto_dash/presentation/features/speedometer/bloc/speedometer_bloc.dart';
import 'package:auto_dash/presentation/features/speedometer/models/speed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeedTintWrapper extends StatelessWidget {
  const SpeedTintWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  Color getTintColor(Speed speed) {
    final kmPerHour = speed.kilometersPerHour;

    final firstColor = Color.fromARGB(255, 58, 255, 61);
    final firstColorMaxOpacity = 0.05;
    final secondColor = Colors.red;
    final secondColorMaxOpacity = 0.05;

    if (kmPerHour <= 100) {
      // For speed from 0 to 100, transition opacity from 0 to 0.1 (10%)
      final opacity = (kmPerHour / 100) * firstColorMaxOpacity;
      return firstColor.withOpacity(opacity);
    } else {
      // For speed above 100, transition color from white to red
      // Assume that 200 km/h is where it reaches full red
      var factor = (kmPerHour - 100) / 100;
      factor = factor.clamp(0.0, 1.0); // Ensure factor is between 0 and 1
      return Color.lerp(
          firstColor.withOpacity(firstColorMaxOpacity), secondColor.withOpacity(secondColorMaxOpacity), factor)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final speedometerState = context.watch<SpeedometerBloc>().state;
    if (speedometerState is SpeedometerData) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: getTintColor(speedometerState.speed),
        child: child,
      );
    }
    return child;
  }
}
