import 'package:auto_dash/presentation/features/speedometer/bloc/speedometer_bloc.dart';
import 'package:auto_dash/presentation/features/speedometer/view/widgets/location_permission_denied.dart';
import 'package:auto_dash/presentation/features/speedometer/view/widgets/speedometer.dart';
import 'package:auto_dash/presentation/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpeedometerStateBuilder extends StatelessWidget {
  const SpeedometerStateBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeedometerBloc, SpeedometerState>(
      builder: (context, state) {
        return switch (state) {
          SpeedometerInitial() => const LoadingIndicator(),
          LoadingSpeedometerData() => const LoadingIndicator(),
          SpeedometerError() => Text(state.error),
          DeniedLocationPermissions() => const LocationPermissionDenied(),
          SpeedometerData() => Speedometer(
              speed: state.speed,
            ),
        };
      },
    );
  }
}
