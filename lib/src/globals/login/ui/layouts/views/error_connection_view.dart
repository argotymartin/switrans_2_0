import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';

class ErrorConnectionScreen extends StatelessWidget {
  final String message;
  const ErrorConnectionScreen({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Lottie.asset(
              'assets/animations/error-connection.json',
              height: size.height * 0.5,
              width: size.height * 0.5,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "Error en conexion con el servidor",
            style: TextStyle(
              fontSize: size.height * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: size.height * 0.02,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            "Por favor, contacte al grupo de soporte tecnico y reporte la novedad",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.height * 0.02,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          ElevatedButton(
            onPressed: () {
              AppRouter.router.push("/sign-in");
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
              backgroundColor: Colors.blue.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              "Ir a login",
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
