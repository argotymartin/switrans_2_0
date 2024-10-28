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
    super.initState();
    if (widget.optionSelected == null) {
      optionSelected = Options.todo;
    } else if (widget.optionSelected!) {
      optionSelected = Options.si;
    } else {
      optionSelected = Options.no;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SegmentedButton<Options>(
          segments: const <ButtonSegment<Options>>[
            ButtonSegment<Options>(
              value: Options.todo,
              label: SizedBox(
                height: 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('Todos'),
                ),
              ),
              icon: Icon(Icons.list),
            ),
            ButtonSegment<Options>(
              value: Options.si,
              label: SizedBox(
                height: 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('Si'),
                ),
              ),
              icon: Icon(Icons.check_box_outlined),
            ),
            ButtonSegment<Options>(
              value: Options.no,
              label: SizedBox(
                height: 20,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('No'),
                ),
              ),
              icon: Icon(Icons.cancel),
            ),
          ],
          selected: <Options>{optionSelected},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                if (optionSelected == Options.si) {
                  return const Color(0xFFB2EBAF);
                } else if (optionSelected == Options.no) {
                  return const Color(0xFFFFC0CB);
                }
              }
              return null;
            }),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
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
        ),
      ),
    );
  }
}
