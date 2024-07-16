import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class WebDatePicker2 extends StatefulWidget {
  const WebDatePicker2({
    required this.controller,
    this.initialDate,
    this.onChange,
    super.key,
  });

  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onChange;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _WebDatePicker2State();
}

class _WebDatePicker2State extends State<WebDatePicker2> {
  late List<DateTime?> dialogCalendarPickerValue;
  @override
  void initState() {
    DateTime dateStar = DateTime.now();
    DateTime dateEnd = dateStar.subtract(const Duration(days: 1));
    if (widget.controller.text.isNotEmpty) {
      final List<String> fechas = widget.controller.text.split(" - ");
      dateStar = DateTime.parse(fechas[0]);
      dateEnd = DateTime.parse(fechas[1]);
    }

    dialogCalendarPickerValue = <DateTime?>[
      dateEnd,
      dateStar,
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle dayTextStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final TextStyle weekendTextStyle = TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final TextStyle anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final CalendarDatePicker2WithActionButtonsConfig config = CalendarDatePicker2WithActionButtonsConfig(
      calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
      dayTextStyle: dayTextStyle,
      calendarType: CalendarDatePicker2Type.range,
      closeDialogOnCancelTapped: true,
      firstDayOfWeek: 1,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      centerAlignModePicker: true,
      customModePickerIcon: const SizedBox(),
      selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
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
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      child: TextFormField(
        controller: widget.controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          final List<DateTime?>? values = await showCalendarDatePicker2Dialog(
            context: context,
            config: config.copyWith(
              dayMaxWidth: 32,
              controlsHeight: 40,
              disableMonthPicker: true,
              hideYearPickerDividers: true,
            ),
            dialogSize: const Size(400, 350),
            borderRadius: BorderRadius.circular(15),
            value: dialogCalendarPickerValue,
            dialogBackgroundColor: Colors.white,
          );
          if (values != null) {
            setState(() {
              dialogCalendarPickerValue = values;
              widget.controller.text = _getValueText(config.calendarType, values);
            });
          }
        },
      ),
    );
  }
}

String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values) {
  final List<DateTime?> valuesValidate = values.map((DateTime? e) => e != null ? DateUtils.dateOnly(e) : null).toList();

  String valueText = (valuesValidate.isNotEmpty ? valuesValidate[0] : null).toString().replaceAll('00:00:00.000', '');

  if (datePickerType == CalendarDatePicker2Type.range) {
    if (valuesValidate.isNotEmpty) {
      final String startDate = valuesValidate[0].toString().replaceAll('00:00:00.000', '').trim();
      final String endDate = valuesValidate.length > 1 ? valuesValidate[1].toString().replaceAll('00:00:00.000', '').trim() : startDate;
      valueText = '$startDate - $endDate';
    } else {
      return 'null';
    }
  }

  return valueText;
}
