import 'package:auto_dash/presentation/features/speedometer/view/speedometer_state_builder.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpeedometerStateBuilder(),
        ],
      ),
    );
  }
}
