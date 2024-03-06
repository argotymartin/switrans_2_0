import 'package:flutter/material.dart';

enum Option { option1, option2 }

class RadioButtons extends StatefulWidget {
  const RadioButtons({
    super.key,
    required this.tipo,
  });
  final String tipo;

  @override
  State<RadioButtons> createState() => _MyAppState();
}

class _MyAppState extends State<RadioButtons> {
  Option? selectedOption;
  @override
  void initState() {
    if (widget.tipo == "TR") {
      selectedOption = Option.option1;
    } else if (widget.tipo == "SA") {
      selectedOption = Option.option2;
    }
    super.initState();
  }

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
                  onChanged: widget.tipo.isEmpty ? (Option? value) => setState(() => selectedOption = value) : null,
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
                  onChanged: widget.tipo.isEmpty ? (Option? value) => setState(() => selectedOption = value) : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
