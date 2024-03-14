import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';

class CustomDatetimeInput extends StatefulWidget {
  final TextEditingController controller;
  final String initialValue;
  final String title;
  final Function(String result)? onChanged;
  final bool isValidator;
  const CustomDatetimeInput({
    super.key,
    required this.controller,
    required this.title,
    this.initialValue = '',
    this.onChanged,
    this.isValidator = false,
  });

  @override
  State<StatefulWidget> createState() => _DatetimeInput();
}

class _DatetimeInput extends State<CustomDatetimeInput> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title.isNotEmpty ? Text(widget.title, style: AppTheme.titleStyle) : const SizedBox(),
        widget.title.isNotEmpty ? const SizedBox(height: 8) : const SizedBox(),
        Center(
          child: SizedBox(
            height: 40,
            child: TextField(
              controller: widget.controller,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                hintText: "Seleccione fecha",
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              readOnly: true,
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                  locale: const Locale('es', 'ES'),
                );

                if (pickedDate != null) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    widget.controller.text = formattedDate;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
