import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessDialog {
  static showSuccesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Icon(Icons.info_outline_rounded, size: 80, color: Theme.of(context).colorScheme.error),
              Text(
                "Se grabo con exito",
                style: TextStyle(color: Theme.of(context).colorScheme.background, fontSize: 24),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        actions: [
          FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
        ],
      ),
    );
  }
}
