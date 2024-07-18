import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TokenExpired extends StatelessWidget {
  const TokenExpired({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Su Sesion a Expirado, por favor refresque la pagina"),
            MaterialButton(
              onPressed: () {
                context.go("/sign-in");
              },
              child: const Text("Ir a login"),
            ),
          ],
        ),
      ),
    );
  }
}
