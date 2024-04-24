import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/shared/widgets/modals/error_modal.dart';

class BuildButtonFormSave extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;
  final bool isConsulted;
  final bool isInProgress;
  final bool enabled;
  final int? cantdiad;
  final String error;
  const BuildButtonFormSave({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isConsulted,
    this.enabled = true,
    required this.isInProgress,
    required this.error,
    this.cantdiad = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 8),
            isInProgress
                ? Transform.scale(scale: 0.8, child: const CircularProgressIndicator(strokeWidth: 2.0))
                : isConsulted
                    ? Text(
                        "Actualizar: $cantdiad Registros",
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                      )
                    : const SizedBox(),
            const SizedBox(width: 24),
            FilledButton.icon(
              onPressed: () {
                onPressed.call();
              },
              icon: Icon(icon),
              label: Text(label, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        error.isNotEmpty ? const SizedBox(height: 16) : const SizedBox(),
        error.isNotEmpty ? ErrorModal(title: error) : const SizedBox(),
        const SizedBox(height: 24),
      ],
    );
  }
}
