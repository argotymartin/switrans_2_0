import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/inputs/custom_inputs.dart';

class SerachText extends StatelessWidget {
  const SerachText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: Center(
        child: TextField(
          decoration: CustomInputs.searchInputDecoration(hintText: 'Buscar', icon: Icons.search),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.1),
      );
}
