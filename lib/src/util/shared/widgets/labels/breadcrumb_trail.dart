import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/menu/menu_bloc.dart';

class BreadcrumbTrail extends StatelessWidget {
  final List<String> elements;
  const BreadcrumbTrail({
    required this.elements,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final MenuState menuState = context.watch<MenuBloc>().state;
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat("EEEE, MMMM d 'del' y", 'es').format(now);

    final List<Widget> result = <Widget>[];
    bool primeraIteracion = true;
    for (final String element in elements) {
      if (primeraIteracion) {
        result.add(Text("Switrans", style: TextStyle(color: Colors.blue.shade500)));
        primeraIteracion = false;
      } else {
        result.add(Text("${element[0].toUpperCase()}${element.substring(1)}"));
      }

      result.add(const SizedBox(width: 2));
      result.add(const Text("/"));
      result.add(const SizedBox(width: 2));
    }
    return Row(
      children: <Widget>[
        menuState.isOpenMenu && size.width > 480 ? Row(children: result) : const SizedBox(),
        const Spacer(),
        menuState.isOpenMenu && size.width > 900 ? Text(formattedDate) : const SizedBox(),
      ],
    );
  }
}
