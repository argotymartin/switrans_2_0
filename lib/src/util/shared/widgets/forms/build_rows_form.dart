import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BuildRowsForm extends StatelessWidget {
  final List<Widget> children;
  const BuildRowsForm({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenList = [];
    children.forEachIndexed((index, child) {
      childrenList.add(Expanded(child: child));
      if (index + 1 < children.length && children.length > 1) {
        childrenList.add(const SizedBox(width: 24));
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(children: childrenList),
    );
  }
}
