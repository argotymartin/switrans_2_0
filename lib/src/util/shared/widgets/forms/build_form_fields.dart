import 'package:flutter/material.dart';

class BuildFormFields extends StatelessWidget {
  final List<Widget> children;
  final int spaces;

  const BuildFormFields({
    required this.children,
    this.spaces = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Widget> columnChildren = <Widget>[];

    if (size.width < 720) {
      columnChildren.addAll(
        children.map(
          (Widget child) => Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      );
    } else {
      final int columnsCount;
      if (size.width < spaces * 1200) {
        columnsCount = 2;
      } else if (size.width < spaces * 1600) {
        columnsCount = 3;
      } else {
        columnsCount = 4;
      }
      for (int i = 0; i < children.length; i += columnsCount) {
        final List<Widget> rowChildren = <Widget>[];
        for (int j = 0; j < columnsCount; j++) {
          final int index = i + j;
          if (index < children.length) {
            rowChildren.add(Expanded(child: children[index]));
            if (j < columnsCount - 1) {
              rowChildren.add(const SizedBox(width: 16));
            }
          }
        }
        columnChildren.add(
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(children: rowChildren),
          ),
        );
      }
    }

    return Column(children: columnChildren);
  }
}
