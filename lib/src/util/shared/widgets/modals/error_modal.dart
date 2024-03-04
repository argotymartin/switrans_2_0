import 'package:flutter/material.dart';

class ErrorModal extends StatelessWidget {
  final String title;
  const ErrorModal({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
