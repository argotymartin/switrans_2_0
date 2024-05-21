import 'package:flutter/material.dart';

class SegmentedInput extends StatefulWidget {
  final ValueChanged<bool?> onChanged;
  const SegmentedInput({
    required this.onChanged,
    super.key,
  });

  @override
  State<SegmentedInput> createState() => _SegmentedInputState();
}

enum Options { todo, si, no }

class _SegmentedInputState extends State<SegmentedInput> {
  Options optionSelected = Options.todo;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Options>(
      segments: const <ButtonSegment<Options>>[
        ButtonSegment<Options>(value: Options.todo, label: Text('Todos'), icon: Icon(Icons.list)),
        ButtonSegment<Options>(value: Options.si, label: Text('Si'), icon: Icon(Icons.check_box_outlined)),
        ButtonSegment<Options>(value: Options.no, label: Text('No'), icon: Icon(Icons.not_interested_sharp)),
      ],
      selected: <Options>{optionSelected},
      onSelectionChanged: (Set<Options> newSelection) {
        setState(() {
          optionSelected = newSelection.first;
          final bool? selected = optionSelected == Options.si
              ? true
              : optionSelected == Options.no
                  ? false
                  : null;
          widget.onChanged(selected);
        });
      },
    );
  }
}
