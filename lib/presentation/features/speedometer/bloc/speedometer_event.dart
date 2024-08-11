part of 'speedometer_bloc.dart';

sealed class SpeedometerEvent {
  const SpeedometerEvent();
}

final class GetSpeedometerData extends SpeedometerEvent {
  const GetSpeedometerData();
}

final class RequestLocationPermissions extends SpeedometerEvent {
  const RequestLocationPermissions();
}

final class LoadSpeedometer extends SpeedometerEvent {
  const LoadSpeedometer();
}

final class SpeedChanged extends SpeedometerEvent {
  const SpeedChanged({
    required this.speed,
  });

  final double speed;
}

final class SpeedometerErrorEvent extends SpeedometerEvent {
  const SpeedometerErrorEvent({
    required this.error,
  });

  final Object error;
}
