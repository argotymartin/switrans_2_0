import 'package:flutter/material.dart';

class SwitchBoxInput extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SwitchBoxInput({
    super.key,
    this.value = false,
    this.onChanged,
  });

  @override
  State<SwitchBoxInput> createState() => _SwitchBoxInputState();
}

class _SwitchBoxInputState extends State<SwitchBoxInput> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Switch(
        value: _value,
        onChanged: (bool value) {
          setState(() => _value = value);
          widget.onChanged?.call(value);
        },
        thumbIcon: WidgetStateProperty.resolveWith<Icon>(
          (Set<WidgetState> states) {
            if (_value) {
              return const Icon(Icons.check, color: Colors.black);
            } else {
              return const Icon(Icons.close, color: Colors.white);
            }
          },
        ),
      ),
    );
  }
}
