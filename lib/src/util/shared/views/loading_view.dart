import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String text;
  final Color colorText;
  const LoadingView({super.key, this.text = "", this.colorText = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/animations/loading.gif"),
            const SizedBox(height: 4),
            Text(
              "Por favor espere...",
              style: TextStyle(fontSize: 16, color: colorText),
            ),
            const SizedBox(height: 4),
            Text(text),
          ],
        ),
      ),
    );
  }
}
