import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:faker/faker.dart';

class AutocompleteInput extends StatefulWidget {
  final String labelText;
  const AutocompleteInput({super.key, required this.labelText});

  @override
  State<AutocompleteInput> createState() => _AutocompleteInputState();
}

class _AutocompleteInputState extends State<AutocompleteInput> {
  late TextEditingController controllerCity = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TypeAheadField<String?>(
                      autoFlipDirection: true,
                      suggestionsCallback: CityData.getSuggestions,
                      itemBuilder: (context, String? suggestion) => ListTile(
                            title: Text(suggestion!),
                            leading: const Icon(Icons.info),
                            subtitle: const Text(
                              "80004861-4",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                      builder: (context, controller, focusNode) {
                        controllerCity = controller;
                        return TextField(
                          controller: controllerCity,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_rounded, color: Colors.grey),
                            border: const OutlineInputBorder(),
                            labelText: "Seleccione un ${widget.labelText}",
                          ),
                        );
                      },
                      onSelected: (String? suggestion) {
                        controllerCity.text = suggestion!;
                      },
                      loadingBuilder: (context) => const Text('Loading...'),
                      errorBuilder: (context, error) => const Text('Error!'),
                      emptyBuilder: (context) => const Text('No items found!'),
                      decorationBuilder: (context, child) {
                        return Material(
                          type: MaterialType.card,
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: child,
                        );
                      },
                      offset: const Offset(0, 12),
                      constraints: const BoxConstraints(maxHeight: 500),
                      transitionBuilder: (context, animation, child) {
                        return FadeTransition(
                          opacity: CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
                          child: child,
                        );
                      })
                ],
              ),
            ),
          ),
        ),
      );
}

class CityData {
  static final faker = Faker();

  static final List<String> cities = List.generate(20, (index) => faker.company.name());

  static List<String> getSuggestions(String query) => List.of(cities).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}
