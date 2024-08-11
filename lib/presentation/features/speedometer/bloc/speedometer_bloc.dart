import 'dart:async';

import 'package:auto_dash/domain/exceptions/geolocation_exception.dart';
import 'package:auto_dash/domain/repositories/geolocator_repository.dart';
import 'package:auto_dash/presentation/features/speedometer/models/speed.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'speedometer_event.dart';
part 'speedometer_state.dart';

class SpeedometerBloc extends Bloc<SpeedometerEvent, SpeedometerState> {
  SpeedometerBloc({
    required GeolocatorRepository geolocationRepository,
  })  : _geolocationRepository = geolocationRepository,
        super(const SpeedometerInitial()) {
    on<GetSpeedometerData>(_onGetSpeedometerData);
    on<RequestLocationPermissions>(_onRequestLocationPermissions);
    on<LoadSpeedometer>(_onLoadSpeedometer);
    on<SpeedChanged>(_onSpeedChanged);
    on<SpeedometerErrorEvent>(_onSpeedometerErrorEvent);

    if (state is SpeedometerInitial) {
      add(const LoadSpeedometer());
    }
  }

  final GeolocatorRepository _geolocationRepository;
  StreamSubscription<Position>? _positionStream;

  FutureOr<void> _onGetSpeedometerData(GetSpeedometerData event, Emitter<SpeedometerState> emit) async {
    if (_positionStream != null) {
      return;
    }
    try {
      final positionStream = _geolocationRepository.getPositionStream();
      add(
        SpeedChanged(
          speed: Speed.fromMeterPerSecond(
            0,
          ),
        ),
      );
      // await simulateAcceleration();
      _positionStream = positionStream.listen((position) {
        add(SpeedChanged(speed: Speed.fromMeterPerSecond(position.speed)));
      }, onError: (e) {
        add(SpeedometerErrorEvent(error: e));
      });
    } catch (e) {
      emit(SpeedometerError(error: e.toString()));
    }
  }

  Future<void> simulateAcceleration() async {
    for (var i = 0; i < 100; i++) {
      await Future.delayed(const Duration(milliseconds: 500));
      add(SpeedChanged(speed: Speed.fromMeterPerSecond(i.toDouble())));
    }
  }

  FutureOr<void> _onRequestLocationPermissions(RequestLocationPermissions event, Emitter<SpeedometerState> emit) async {
    if (state is! DeniedLocationPermissions) {
      return;
    }
    try {
      await _geolocationRepository.checkPermissions();
      add(const GetSpeedometerData());
    } on LocationPermissionsNotGrantedException {
      emit(const DeniedLocationPermissions());
    } on Exception catch (e) {
      emit(SpeedometerError(error: e.toString()));
    }
  }

  FutureOr<void> _onLoadSpeedometer(LoadSpeedometer event, Emitter<SpeedometerState> emit) async {
    emit(const LoadingSpeedometerData());
    try {
      await _geolocationRepository.checkPermissions();
      add(const GetSpeedometerData());
    } on LocationPermissionsNotGrantedException {
      emit(const DeniedLocationPermissions());
    } on Exception catch (e) {
      emit(SpeedometerError(error: e.toString()));
    }
  }

  FutureOr<void> _onSpeedChanged(event, Emitter<SpeedometerState> emit) {
    if (event is SpeedChanged) {
      emit(SpeedometerData(speed: event.speed));
    }
  }

  FutureOr<void> _onSpeedometerErrorEvent(SpeedometerErrorEvent event, Emitter<SpeedometerState> emit) {
    emit(SpeedometerError(error: event.error.toString()));
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
