// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class AutocompleteInput extends StatelessWidget {
  final List<SuggestionModel> suggestions;
  final String title;

  const AutocompleteInput({
    Key? key,
    required this.suggestions,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SearchField(
          searchStyle: const TextStyle(fontSize: 12),
          autoCorrect: true,
          maxSuggestionsInViewPort: 4,
          textCapitalization: TextCapitalization.sentences,
          onSearchTextChanged: (query) {
            final filter = suggestions.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
            return filter.map((e) => SearchFieldListItem<String>(e.title, child: _ItemAutoComplete(suggestionModel: e))).toList();
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
          suggestions: suggestions.map((e) => SearchFieldListItem<String>(e.title, child: _ItemAutoComplete(suggestionModel: e))).toList(),
          focusNode: focus,
          suggestionState: Suggestion.expand,
          onSuggestionTap: (SearchFieldListItem x) {
            focus.unfocus();
          },
        ),
      ],
    );
  }
}

class _ItemAutoComplete extends StatefulWidget {
  final SuggestionModel suggestionModel;
  const _ItemAutoComplete({required this.suggestionModel});

  @override
  State<_ItemAutoComplete> createState() => _ItemAutoCompleteState();
}

class _ItemAutoCompleteState extends State<_ItemAutoComplete> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: Container(
          color: isHovered ? Theme.of(context).colorScheme.primaryContainer : Colors.white,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary, offset: const Offset(1, 1))],
                ),
                child: Text(
                  widget.suggestionModel.codigo,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.suggestionModel.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(widget.suggestionModel.subTitle,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: Colors.black54)),
                  SizedBox(height: 16, child: FittedBox(fit: BoxFit.contain, child: widget.suggestionModel.details))
                ],
              ),
            ],
          ),
        ),
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
    required this.codigo,
    required this.subTitle,
    this.details = const SizedBox(),
  });
}
