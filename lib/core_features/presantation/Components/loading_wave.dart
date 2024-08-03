import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWave extends StatelessWidget {
  const LoadingWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(
      "assets\\loading_wave.json",
      width: 200,
      height: 200,
    ));
  }
}
