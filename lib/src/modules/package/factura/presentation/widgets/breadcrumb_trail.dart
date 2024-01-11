import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BreadcrumbTrail extends StatelessWidget {
  final List<String> elements;
  const BreadcrumbTrail({
    super.key,
    required this.elements,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    List<Widget> result = [];
    bool primeraIteracion = true;
    for (var element in elements) {
      if (primeraIteracion) {
        result.add(Text(element, style: TextStyle(color: Colors.blue.shade500)));
        primeraIteracion = false; // Cambiar la variable para evitar repetir la acción
      } else {
        result.add(Text(element, style: TextStyle(color: Colors.grey.shade500)));
      }

      result.add(const SizedBox(width: 4));
      result.add(const Text("/"));
      result.add(const SizedBox(width: 4));
    }
    return Row(
      children: [
        Row(children: result),
        const Spacer(),
        Text(formattedDate, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
