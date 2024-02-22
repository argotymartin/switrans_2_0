import 'package:flutter/material.dart';

class EntryAutocomplete {
  final String title;
  final int codigo;
  final String subTitle;
  final Widget details;

  EntryAutocomplete({
    required this.title,
    required this.subTitle,
    this.details = const SizedBox(width: 1, height: 1),
    this.codigo = 0,
  });
}
