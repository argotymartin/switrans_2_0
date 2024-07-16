// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BuildFlexFormFields extends StatelessWidget {
  final List<FlexWidgetForm> children;

  const BuildFlexFormFields({
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<Widget> columnChildren = <Widget>[];

    if (size.width < 720) {
      columnChildren.addAll(
        children.map(
          (FlexWidgetForm child) => Padding(
            padding: const EdgeInsets.all(24),
            child: child.widget,
          ),
        ),
      );
    } else {
      final int columnsCount;
      if (size.width < 1200) {
        columnsCount = 2;
      } else if (size.width < 2000) {
        columnsCount = 3;
      } else {
        columnsCount = 4;
      }
      for (int i = 0; i < children.length; i += columnsCount) {
        final List<Widget> rowChildren = <Widget>[];
        for (int j = 0; j < columnsCount; j++) {
          final int index = i + j;
          if (index < children.length) {
            rowChildren.add(
              Expanded(
                flex: children[index].flex,
                child: Padding(padding: const EdgeInsets.only(right: 24), child: children[index].widget),
              ),
            );
          }
        }
        columnChildren.add(
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowChildren),
          ),
        );
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: columnChildren);
  }
}

class FlexWidgetForm {
  final int flex;
  final Widget widget;

  FlexWidgetForm({
    required this.widget,
    required this.flex,
  });
}
