import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WebDatePicker extends StatefulWidget {
  const WebDatePicker({
    super.key,
    this.initialDate,
    this.onChange,
    this.controller,
  });

  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onChange;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() => _WebDatePickerState();
}

class _WebDatePickerState extends State<WebDatePicker> {
  late OverlayEntry _overlayEntry;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  late TextEditingController _controller;
  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;
  bool _isEnterDateField = false;
  final String dateformat = 'yyyy/MM/dd';
  final DateTime _currentDate = DateTime.now();
  String currentYear = "";

  @override
  void initState() {
    _controller = widget.controller!;
    super.initState();
    _selectedDate = widget.initialDate;
    _firstDate = DateTime(2000);
    _lastDate = DateTime(2100);
    currentYear = _currentDate.parseToString('yyyy');

    if (_selectedDate != null) {
      _controller.text = _selectedDate?.parseToString(dateformat) ?? '';
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

  void onChangeCalendarDatePicker(DateTime? selectedDate) {
    setState(() {
      final String selectedYear = selectedDate.parseToString('yyyy');
      if (selectedYear == currentYear) {
        _overlayEntry.remove();
        _selectedDate = selectedDate;
        setState(() {});
      } else {
        _selectedDate = selectedDate;
        currentYear = selectedYear;
        setState(() {});
      }
    });
    if (widget.onChange != null) {
      widget.onChange!.call(selectedDate);
    }
    _controller.text = _selectedDate.parseToString(dateformat);
    _focusNode.unfocus();
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
          width: 200,
          height: 36,
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: const OutlineInputBorder(),
              suffixIcon: _buildPrefixIcon(),
            ),
            onChanged: (String dateString) {
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
    if (_controller.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.error,
        ),
        onPressed: () {
          _controller.clear();
          _selectedDate = null;
          _focusNode.hasFocus;
        },
        splashRadius: 16,
      );
    } else {
      return IconButton(
        icon: Icon(
          Icons.calendar_month_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          if (!_overlayEntry.mounted) {
            Overlay.of(context).insert(_overlayEntry);
          }
        },
        splashRadius: 16,
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
