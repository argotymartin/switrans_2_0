import 'package:flutter/material.dart';

class BuildRowsForm extends StatelessWidget {
  final List<Widget> children;
  const BuildRowsForm({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final childrenMap = children.map((child) => Expanded(child: child)).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(children: childrenMap),
    );
  }
}
