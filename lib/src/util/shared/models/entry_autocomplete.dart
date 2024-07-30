import 'package:flutter/material.dart';

class EntryAutocomplete {
  final String title;
  final int? codigo;
  final String subTitle;
  final Widget? details;

  EntryAutocomplete({
    required this.title,
    this.subTitle = '',
    this.details,
    this.codigo,
  });
}
