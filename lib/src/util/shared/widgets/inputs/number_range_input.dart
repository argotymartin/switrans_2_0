import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class NumberRangeInput extends StatefulWidget {
  final int min;
  final int max;
  final ValueChanged<int> onChanged1;
  final ValueChanged<int> onChanged2;
  const NumberRangeInput({required this.min, required this.max, required this.onChanged1, required this.onChanged2, super.key});

  @override
  State<NumberRangeInput> createState() => _NumberRangeInputState();
}

class _NumberRangeInputState extends State<NumberRangeInput> {
  late TextEditingController controller1;
  late TextEditingController controller2;
  int number1 = 0;
  int number2 = 0;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController(text: number1.toString());
    controller2 = TextEditingController(text: number2.toString());
  }

  void _updateNumber1(int value) {
    setState(() {
      number1 = value.clamp(widget.min, widget.max);
      controller1.text = number1.toString();
      widget.onChanged1.call(number1);
    });
  }

  void _updateNumber2(int value) {
    setState(() {
      number2 = value.clamp(widget.min, widget.max);
      controller2.text = number2.toString();
      widget.onChanged2.call(number2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _buildInputNumber(controller1, number1, _updateNumber1),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(" - ", style: AppTheme.titleStyle),
        ),
        Expanded(
          child: _buildInputNumber(controller2, number2, _updateNumber2),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.only(bottom: 8, left: 8),
      constraints: const BoxConstraints(maxHeight: 37, minHeight: 12),
      border: InputBorder.none,
      hintText: 'Ingresa un número',
    );
  }

  Widget _buildInputNumber(TextEditingController controller, int number, ValueChanged<int> onChanged) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black87,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 4, left: 8),
            child: Icon(Icons.numbers_rounded, size: 22, color: Colors.black45),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration(context),
                onChanged: (String value) {
                  if (value.isNotEmpty) {
                    final int parsedValue = int.parse(value);
                    onChanged(parsedValue.clamp(widget.min, widget.max));
                  }
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8, top: 8, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                number == 0
                    ? const SizedBox()
                    : IconButton(
                        constraints: const BoxConstraints(maxHeight: 24, maxWidth: 28),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () => onChanged(0),
                      ),
                IconButton(
                  constraints: const BoxConstraints(maxHeight: 24, maxWidth: 28),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () => onChanged(number - 1),
                ),
                IconButton(
                  constraints: const BoxConstraints(maxHeight: 24, maxWidth: 28),
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () => onChanged(number + 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
