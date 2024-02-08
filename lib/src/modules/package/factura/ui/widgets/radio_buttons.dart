import 'package:flutter/material.dart';

enum Option { option1, option2 }

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key});

  @override
  State<RadioButtons> createState() => _MyAppState();
}

class _MyAppState extends State<RadioButtons> {
  Option? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 48,
          child: Row(
            children: [
              const Text("TR", style: TextStyle(fontSize: 10)),
              Transform.scale(
                scale: 0.8,
                child: Radio<Option>(
                  value: Option.option1,
                  groupValue: selectedOption,
                  splashRadius: 2,
                  onChanged: (Option? value) => setState(() => selectedOption = value),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 48,
          child: Row(
            children: [
              const Text("SA", style: TextStyle(fontSize: 10)),
              Transform.scale(
                scale: 0.8,
                child: Radio<Option>(
                  toggleable: false,
                  value: Option.option2,
                  groupValue: selectedOption,
                  splashRadius: 2,
                  onChanged: (Option? value) => setState(() => selectedOption = value),
                ),
              ),
            ],
          ),
        ),
        // Text('Selected Option: ${selectedOption ?? 'None'}'),
      ],
    );
  }
}
