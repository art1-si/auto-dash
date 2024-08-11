import 'dart:async';

import 'package:auto_dash/domain/exceptions/geolocation_exception.dart';
import 'package:auto_dash/domain/repositories/geolocator_repository.dart';
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
    final positionStream = _geolocationRepository.getPositionStream();
    _positionStream = positionStream.listen((position) {
      emit(SpeedometerData(speed: position.speed));
    }, onError: (e) {
      emit(SpeedometerError(error: e.toString()));
    });
  }

  FutureOr<void> _onRequestLocationPermissions(RequestLocationPermissions event, Emitter<SpeedometerState> emit) async {
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

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
