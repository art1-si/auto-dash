part of 'speedometer_bloc.dart';

sealed class SpeedometerState {
  const SpeedometerState();
}

final class SpeedometerInitial extends SpeedometerState {
  const SpeedometerInitial();
}

final class DeniedLocationPermissions extends SpeedometerState {
  const DeniedLocationPermissions();
}

final class SpeedometerData extends SpeedometerState {
  const SpeedometerData({
    required this.speed,
  });

  final Speed speed;
}

final class LoadingSpeedometerData extends SpeedometerState {
  const LoadingSpeedometerData();
}

final class SpeedometerError extends SpeedometerState {
  const SpeedometerError({
    required this.error,
  });

  final String error;
}
