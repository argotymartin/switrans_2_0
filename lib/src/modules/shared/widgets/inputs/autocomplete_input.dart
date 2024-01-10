// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

// ignore: must_be_immutable
class AutocompleteInput extends StatelessWidget {
  final String labelText;
  final Future<List<String?>> Function(String) processFunction;
  late TextEditingController incomingController;
  AutocompleteInput({
    Key? key,
    required this.labelText,
    required this.processFunction,
    required this.incomingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TypeAheadField<String?>(
              autoFlipDirection: true,
              suggestionsCallback: processFunction,
              itemBuilder: (context, String? suggestion) => ListTile(
                title: Text(suggestion!),
                leading: const Icon(Icons.info),
                subtitle: const Text("80004861-4", style: TextStyle(fontSize: 12)),
              ),
              builder: (context, controller, focusNode) {
                incomingController = controller;
                return TextField(
                  controller: incomingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    prefixIconColor: Colors.grey,
                    prefixIcon: const Icon(Icons.search_rounded),
                    border: const OutlineInputBorder(),
                    labelText: "Seleccione un $labelText",
                  ),
                );
              },
              onSelected: (String? suggestion) {
                incomingController.text = suggestion!;
              },
              loadingBuilder: (context) => const Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Cargando.........'),
                ],
              ),
              errorBuilder: (context, error) => const Text('Ocurrio un error'),
              emptyBuilder: (context) => Text('No se encontraron $labelText !'),
              hideOnSelect: true,
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
              },
            )
          ],
        ),
      ),
    );
  }
}
