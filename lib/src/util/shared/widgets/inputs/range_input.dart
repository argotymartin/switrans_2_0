import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RangeInput extends StatefulWidget {
  final int min;
  final int max;
  final double interval;
  final SfRangeValues initialValue;
  final ValueChanged<SfRangeValues>? onChanged;
  const RangeInput({required this.min, required this.max, required this.interval, required this.initialValue, super.key, this.onChanged});

  @override
  State<RangeInput> createState() => _RangeInputState();
}

class _RangeInputState extends State<RangeInput> {
  late SfRangeValues initialValue;
  @override
  void initState() {
    super.initState();
    initialValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SfRangeSlider(
      min: widget.min,
      max: widget.max,
      values: widget.initialValue,
      interval: widget.interval,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      activeColor: Theme.of(context).colorScheme.primaryFixedDim,
      numberFormat: NumberFormat.decimalPattern(),
      minorTickShape: const SfTickShape(),
      onChanged: widget.onChanged == null
          ? null
          : (SfRangeValues values) {
              final SfRangeValues roundedValues = SfRangeValues(values.start.round(), values.end.round());
              setState(() => initialValue = roundedValues);
              widget.onChanged?.call(roundedValues);
            },
    );
  }
}
