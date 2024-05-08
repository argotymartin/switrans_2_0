import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/animations/loading.gif"),
            const SizedBox(height: 4),
            const Text("Por favor espere..."),
          ],
        ),
      ),
    );
  }
}
