import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(child: Center(child: Lottie.asset("animations/loading.json", height: 200)));
  }
}
