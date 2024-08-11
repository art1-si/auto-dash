import 'package:auto_dash/domain/repositories/geolocator_repository.dart';
import 'package:auto_dash/presentation/features/speedometer/bloc/speedometer_bloc.dart';
import 'package:auto_dash/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoDashApp extends StatelessWidget {
  const AutoDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => SpeedometerBloc(
          geolocationRepository: GeolocatorRepository(),
        ),
        child: HomeScreen(),
      ),
    );
  }
}
