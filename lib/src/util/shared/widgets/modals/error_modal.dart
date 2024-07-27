import 'package:flutter/material.dart';

class ErrorModal extends StatelessWidget {
  final String title;
  const ErrorModal({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.error, color: Theme.of(context).colorScheme.onTertiary),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: Theme.of(context).colorScheme.onTertiary)),
        ],
      ),
    );
  }
}
