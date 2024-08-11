import 'package:auto_dash/presentation/features/speedometer/view/speedometer_state_builder.dart';
import 'package:auto_dash/presentation/shared/speed_tint_wrapper.dart';
import 'package:auto_dash/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundGradientColorTop,
            AppColors.backgroundGradientColorBottom,
          ],
        ),
      ),
      child: const SpeedTintWrapper(
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpeedometerStateBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
