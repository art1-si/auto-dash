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
