import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorLayout extends StatelessWidget {
  final GoRouterState goRouterState;
  const ErrorLayout({
    required this.goRouterState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(goRouterState.error.toString()),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                context.go("/");
              },
              child: const Text("Ir a Home"),
            ),
          ],
        ),
      ),
    );
  }
}
