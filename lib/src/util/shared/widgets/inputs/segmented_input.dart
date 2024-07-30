import 'package:flutter/material.dart';

class SegmentedInput extends StatefulWidget {
  final ValueChanged<bool?> onChanged;
  final bool? optionSelected;
  const SegmentedInput({
    required this.onChanged,
    required this.optionSelected,
    super.key,
  });

  @override
  State<SegmentedInput> createState() => _SegmentedInputState();
}

enum Options { todo, si, no }

class _SegmentedInputState extends State<SegmentedInput> {
  late Options optionSelected;

  @override
  void initState() {
    if (widget.optionSelected == null) {
      optionSelected = Options.todo;
    } else if (widget.optionSelected!) {
      optionSelected = Options.si;
    } else {
      optionSelected = Options.no;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Options>(
      segments: const <ButtonSegment<Options>>[
        ButtonSegment<Options>(
          value: Options.todo,
          label: SizedBox(
            height: 20,
            child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('Todos')),
          ),
          icon: Icon(Icons.list),
        ),
        ButtonSegment<Options>(
          value: Options.si,
          label: SizedBox(
            height: 20,
            child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('Si')),
          ),
          icon: Icon(Icons.check_box_outlined),
        ),
        ButtonSegment<Options>(
          value: Options.no,
          label: SizedBox(
            height: 20,
            child: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text('No')),
          ),
          icon: Icon(Icons.not_interested_sharp),
        ),
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
