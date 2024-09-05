import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TokenExpired extends StatelessWidget {
  const TokenExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;
            final bool isPortrait = height > width;
            final double imageWidth = isPortrait ? width * 0.2 : width * 0.15;
            final double imageHeight = isPortrait ? height * 0.15 : height * 0.2;
            final double buttonPadding = width * 0.1;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width * 0.8,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/token_expired.png',
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        "Su sesión ha expirado",
                        style: TextStyle(
                          fontSize: height * 0.03,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        "Por favor, refresca la página para iniciar sesión nuevamente.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: height * 0.02,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: height * 0.04),
                      ElevatedButton(
                        onPressed: () {
                          context.go("/sign-in");
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: buttonPadding, vertical: width * 0.02),
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Ir a login",
                          style: TextStyle(
                            fontSize: height * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
