import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class AutocompleteInput extends StatelessWidget {
  final List<SuggestionModel> suggestions;
  const AutocompleteInput({super.key, required this.suggestions});

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SearchField(
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
            if (value == null || value.length < 4) {
              return 'error';
            }
            return null;
          },
          key: const Key('searchfield'),
          hint: 'Buscar Cliente',
          itemHeight: 68,
          scrollbarDecoration: ScrollbarDecoration(trackColor: Colors.red),
          suggestionStyle: const TextStyle(fontSize: 24, color: Colors.black),
          searchInputDecoration: InputDecoration(
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
            border: Border.all(color: Colors.indigo, width: 1),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: MouseRegion(
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
          color: isHovered ? Colors.blue : Colors.white,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [BoxShadow(color: Colors.red, offset: Offset(1, 1))],
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
