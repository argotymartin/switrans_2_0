// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Autocomplete2Input extends StatelessWidget {
  final List<EntiresAutocomplete> entries;
  final String label;
  final TextEditingController controller;
  const Autocomplete2Input({
    Key? key,
    required this.entries,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries = entries.map<DropdownMenuEntry<EntiresAutocomplete>>(
      (entry) {
        return DropdownMenuEntry<EntiresAutocomplete>(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.grey, width: 0.3)),
          ),
          value: entry,
          label: entry.title,
          leadingIcon: CircleAvatar(child: Text('${entry.codigo}')),
          labelWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
              Text(entry.title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              entry.details,
            ],
          ),
        );
      },
    ).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: DropdownMenu<EntiresAutocomplete>(
          controller: controller,
          enableFilter: true,
          requestFocusOnTap: true,
          leadingIcon: const Icon(Icons.search),
          label: const Text('Cliente'),
          inputDecorationTheme: const InputDecorationTheme(
            //filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
          ),
          onSelected: (EntiresAutocomplete? cliente) {},
          dropdownMenuEntries: dropdownMenuEntries,
        ),
      ),
    );
  }
}

class EntiresAutocomplete {
  final String title;
  final int codigo;
  final String subTitle;
  final Widget details;

  EntiresAutocomplete({
    required this.title,
    required this.subTitle,
    this.details = const SizedBox(width: 1, height: 1),
    this.codigo = 0,
  });
}
