import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeInput extends StatefulWidget {
  const DatetimeInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DatetimeInput();
  }
}

class _DatetimeInput extends State<DatetimeInput> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: dateinput,
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
            );

            if (pickedDate != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                dateinput.text = formattedDate;
              });
            }
          },
        ),
      ),
    );
  }
}
