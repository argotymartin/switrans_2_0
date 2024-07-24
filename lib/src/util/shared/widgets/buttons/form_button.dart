import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class FormButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  const FormButton({required this.label, required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color?>(context.read<ThemeCubit>().state.color),
      ),
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
