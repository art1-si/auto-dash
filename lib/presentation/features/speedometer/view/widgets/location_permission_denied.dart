import 'package:auto_dash/presentation/features/speedometer/bloc/speedometer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationPermissionDenied extends StatelessWidget {
  const LocationPermissionDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Allow location permissions to use Speedometer'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            context.read<SpeedometerBloc>().add(const RequestLocationPermissions());
          },
          child: const Text('Allow location permissions'),
        ),
      ],
    );
  }
}
