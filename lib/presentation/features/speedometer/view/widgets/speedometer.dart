import 'package:flutter/material.dart';

class Speedometer extends StatelessWidget {
  const Speedometer({super.key, required this.speed});

  final double speed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        'Speed: $speed',
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
