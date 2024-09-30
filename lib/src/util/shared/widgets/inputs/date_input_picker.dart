import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DateInputPicker extends StatefulWidget {
  final String? dateInitialValue;
  final ValueChanged<String> onDateSelected;
  final bool autofocus;

  const DateInputPicker({
    required this.onDateSelected,
    this.dateInitialValue,
    this.autofocus = false,
    super.key,
  });

  @override
  State<DateInputPicker> createState() => _DateInputPickerState();
}

class _DateInputPickerState extends State<DateInputPicker> {
  late List<DateTime?> dialogCalendarPickerValue;
  late TextEditingController _controller;
  DateTime? _initialDate;

  @override
  void initState() {
    _controller = TextEditingController(
      text: widget.dateInitialValue ?? '',
    );

    if (widget.dateInitialValue != null) {
      try {
        _initialDate = DateTime.parse(widget.dateInitialValue!);
        dialogCalendarPickerValue = <DateTime?>[_initialDate];
      } on FormatException catch (e) {
        if (kDebugMode) {
          print('Error parsing initial date: $e');
        }
        _initialDate = null;
      }
    }
    if (widget.dateInitialValue == null) {
      dialogCalendarPickerValue = <DateTime?>[DateTime.now()];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle dayTextStyle = TextStyle(fontWeight: FontWeight.w700);
    final TextStyle weekendTextStyle = TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final TextStyle anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final CalendarDatePicker2WithActionButtonsConfig config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.single,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      controlsTextStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      animateToDisplayedMonthDate: true,
      dayTextStylePredicate: ({required DateTime date}) {
        TextStyle? textStyle;
        if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
          textStyle = weekendTextStyle;
        }
        if (DateUtils.isSameDay(date, DateTime(2024, 6, 25))) {
          textStyle = anniversaryTextStyle;
        }
        return textStyle;
      },
      dayBuilder: ({
        required DateTime date,
        TextStyle? textStyle,
        BoxDecoration? decoration,
        bool? isSelected,
        bool? isDisabled,
        bool? isToday,
      }) {
        Widget? dayWidget;
        if (date.day % 3 == 0 && date.day % 9 != 0) {
          dayWidget = DecoratedBox(
            decoration: decoration ?? const BoxDecoration(),
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Text(
                    MaterialLocalizations.of(context).formatDecimal(date.day),
                    style: textStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 27.5),
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected! ? Colors.white : Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return dayWidget;
      },
      yearBuilder: ({
        required int year,
        BoxDecoration? decoration,
        bool? isCurrentYear,
        bool? isDisabled,
        bool? isSelected,
        TextStyle? textStyle,
      }) {
        return Center(
          child: Container(
            decoration: decoration,
            height: 36,
            width: 72,
            child: Center(
              child: Semantics(
                selected: isSelected,
                button: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      year.toString(),
                      style: textStyle,
                    ),
                    if (isCurrentYear == null)
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    return TextFormField(
      controller: _controller,
      autofocus: widget.autofocus,
      style: TextStyle(color: Theme.of(context).colorScheme.inverseSurface),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.calendar_month_outlined),
        constraints: const BoxConstraints(maxHeight: 42, minHeight: 42),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 100,
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      ),
      onTap: () async {
        final List<DateTime?>? values = await showCalendarDatePicker2Dialog(
          context: context,
          config: config.copyWith(
            dayMaxWidth: 32,
            controlsHeight: 40,
            hideYearPickerDividers: true,
          ),
          dialogSize: const Size(450, 350),
          borderRadius: BorderRadius.circular(15),
          value: dialogCalendarPickerValue,
          dialogBackgroundColor: Theme.of(context).colorScheme.surface,
        );
        if (values != null) {
          setState(() {
            _controller.text = _getValueText(config.calendarType, values);
            widget.onDateSelected(_getValueText(config.calendarType, values));
            dialogCalendarPickerValue = values;
          });
        }
      },
    );
  }

  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values) {
    final List<DateTime?> valuesValidate = values.map((DateTime? e) => e != null ? DateUtils.dateOnly(e) : null).toList();

    String valueText = (valuesValidate.isNotEmpty ? valuesValidate[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.range) {
      if (valuesValidate.isNotEmpty) {
        final String startDate = valuesValidate[0].toString().replaceAll('00:00:00.000', '').trim();
        valueText = '$startDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
