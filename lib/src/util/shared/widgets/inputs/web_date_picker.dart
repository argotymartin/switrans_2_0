import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WebDatePicker extends StatefulWidget {
  const WebDatePicker({
    required this.controller,
    this.initialDate,
    this.onChange,
    super.key,
  });

  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onChange;
  final TextEditingController controller;

  @override
  State<StatefulWidget> createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<WebDatePicker> {
  late OverlayEntry _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;
  bool _isEnterDateField = false;
  final String dateformat = 'yyyy/MM/dd';
  final DateTime _currentDate = DateTime.now();
  String currentYear = "";

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _firstDate = DateTime(2000);
    _lastDate = DateTime(2100);
    currentYear = _currentDate.parseToString('yyyy');

    if (_selectedDate != null) {
      widget.controller.text = _selectedDate?.parseToString(dateformat) ?? '';
    }

    _focusNode.addListener(() async {
      await Future<dynamic>.delayed(const Duration(milliseconds: 220));
      _handleFocusChange();
    });
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && _selectedDate == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  Future<void> onChangeCalendarDatePicker(DateTime? selectedDate) async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 220));
    setState(() {
      final String selectedYear = selectedDate.parseToString('yyyy');
      if (selectedYear == currentYear) {
        _selectedDate = selectedDate;
      } else {
        _selectedDate = selectedDate;
        currentYear = selectedYear;
      }

      if (widget.onChange != null) {
        widget.onChange!.call(selectedDate);
      }
      widget.controller.text = _selectedDate.parseToString(dateformat);
      _focusNode.unfocus();
      _selectedDate = null;
      _focusNode.hasFocus;

      if (_overlayEntry.mounted) {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    final Size size = renderBox!.size;

    return OverlayEntry(
      builder: (BuildContext context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 5,
            child: SizedBox(
              height: 250,
              child: CalendarDatePicker(
                firstDate: _firstDate,
                lastDate: _lastDate,
                initialDate: _selectedDate,
                currentDate: _currentDate,
                onDateChanged: onChangeCalendarDatePicker,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isEnterDateField = true),
        onExit: (_) => setState(() => _isEnterDateField = false),
        child: SizedBox(
          height: 36,
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: const OutlineInputBorder(),
              suffixIcon: _buildPrefixIcon(),
            ),
            onChanged: (String dateString) {
              setState(() {});
              final DateTime date = dateString.parseToDateTime(dateformat);
              if (date.isBefore(_firstDate)) {
                _selectedDate = _firstDate;
              } else if (date.isAfter(_lastDate)) {
                _selectedDate = _lastDate;
              } else {
                _selectedDate = date;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (widget.controller.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        iconSize: 20,
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.error,
        ),
        onPressed: () {
          widget.controller.clear();
          _selectedDate = null;
          _focusNode.hasFocus;
        },
        splashRadius: 4,
      );
    } else {
      return IconButton(
        iconSize: 20,
        icon: Icon(
          Icons.calendar_month_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          widget.controller.clear();
          _selectedDate = null;
          _focusNode.hasFocus;
          if (!_overlayEntry.mounted) {
            _handleFocusChange();
            //Overlay.of(context).insert(_overlayEntry);
          }
        },
        splashRadius: 4,
      );
    }
  }
}

extension StringExtension on String {
  DateTime parseToDateTime(String dateFormat) {
    if (length > dateFormat.length) {
      return DateTime.now();
    }
    try {
      return DateFormat(dateFormat).parse(this);
    } on FormatException catch (_) {
      return DateTime.now();
    }
  }
}

extension DateTimeExtension on DateTime? {
  String parseToString(String dateFormat) {
    if (this == null) {
      return '';
    }
    return DateFormat(dateFormat).format(this!);
  }
}
