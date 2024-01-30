// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class AutocompleteInput extends StatelessWidget {
  final List<SuggestionModel> suggestions;
  final String title;
  final TextEditingController controller;

  const AutocompleteInput({
    Key? key,
    required this.suggestions,
    required this.title,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchField(
          searchStyle: const TextStyle(fontSize: 12),
          autoCorrect: true,
          maxSuggestionsInViewPort: 4,
          textCapitalization: TextCapitalization.sentences,
          onSearchTextChanged: (query) {
            final filter = suggestions.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
            return filter
                .map((e) => SearchFieldListItem<String>(e.title, item: e.codigo, child: _ItemAutoComplete(suggestionModel: e)))
                .toList();
          },
          onTap: () {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return 'error';
            }
            return null;
          },
          key: const Key('searchfield'),
          hint: 'Buscar $title',
          itemHeight: 68,
          searchInputDecoration: InputDecoration(
            suffixIcon: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: const Icon(Icons.filter_list_rounded, color: Colors.white),
            ),
            constraints: const BoxConstraints(maxHeight: 38, minHeight: 38),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          suggestionsDecoration: SuggestionDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          suggestions: suggestions
              .map((e) => SearchFieldListItem<String>(e.title, item: e.codigo, child: _ItemAutoComplete(suggestionModel: e)))
              .toList(),
          focusNode: focus,
          suggestionState: Suggestion.expand,
          onSuggestionTap: (SearchFieldListItem x) {
            if (x.item != null) {
              controller.text = x.item;
            }
            //focus.unfocus();
          },
        ),
      ],
    );
  }
}

class _ItemAutoComplete extends StatelessWidget {
  final SuggestionModel suggestionModel;
  const _ItemAutoComplete({required this.suggestionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Row(
        children: [
          const SizedBox(width: 4),
          suggestionModel.codigo != "" ? _BuildSuggestionCodigo(codigo: suggestionModel.codigo) : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(suggestionModel.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Text(suggestionModel.subTitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Colors.black54)),
              SizedBox(height: 16, child: FittedBox(fit: BoxFit.contain, child: suggestionModel.details))
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildSuggestionCodigo extends StatelessWidget {
  final String codigo;
  const _BuildSuggestionCodigo({
    required this.codigo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary, offset: const Offset(1, 1))],
      ),
      child: Text(
        codigo,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

class SuggestionModel {
  final String title;
  final String codigo;
  final String subTitle;
  final Widget details;
  SuggestionModel({
    required this.title,
    required this.subTitle,
    this.details = const SizedBox(),
    this.codigo = "",
  });
}
