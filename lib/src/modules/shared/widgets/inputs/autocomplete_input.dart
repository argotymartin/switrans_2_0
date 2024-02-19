import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/shared/services/search_field.dart';

class AutocompleteInput extends StatelessWidget {
  final List<SuggestionModel> suggestions;
  final String title;
  final bool isShowCodigo;
  final bool isReadOnly;
  final TextEditingController? controller;
  final SuggestionModel? suggestionSelected;
  final Function(String result)? onPressed;

  const AutocompleteInput({
    Key? key,
    required this.suggestions,
    required this.title,
    this.controller,
    this.suggestionSelected,
    this.onPressed,
    this.isShowCodigo = true,
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final focus = FocusNode();
    return SearchField(
      initialValue: suggestionSelected != null
          ? SearchFieldListItem<String>(
              suggestionSelected!.title,
              item: suggestionSelected!.codigo,
            )
          : null,
      readOnly: isReadOnly,
      searchStyle: const TextStyle(fontSize: 12),
      autoCorrect: true,
      maxSuggestionsInViewPort: 4,
      textCapitalization: TextCapitalization.sentences,
      onSearchTextChanged: onTextChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => (value == null) ? 'error' : null,
      key: const Key('searchfield'),
      hint: isReadOnly ? 'Buscar $title' : '',
      itemHeight: 68,
      searchInputDecoration: inputDecoration(context),
      suggestionsDecoration: SuggestionDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      suggestions: suggestions
          .map((e) => SearchFieldListItem<String>(
                e.title,
                item: e.codigo,
                child: _ItemAutoComplete(suggestionModel: e, isShowCodigo: isShowCodigo),
              ))
          .toList(),
      focusNode: focus,
      suggestionState: Suggestion.expand,
      onSuggestionTap: (SearchFieldListItem x) {
        if (x.item != null && controller != null) controller!.text = x.item;
        if (onPressed != null && x.item != null) {
          onPressed?.call(x.item);
        }
      },
    );
  }

  List<SearchFieldListItem<String>>? onTextChanged(query) {
    if (controller != null) controller!.text = "";
    final filter = suggestions
        .where(
          (element) => element.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return filter
        .map((e) => SearchFieldListItem<String>(
              e.title,
              item: e.codigo,
              child: _ItemAutoComplete(suggestionModel: e, isShowCodigo: isShowCodigo),
            ))
        .toList();
  }

  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        child: Icon(Icons.filter_list_rounded, color: Theme.of(context).colorScheme.outline),
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
    );
  }
}

class _ItemAutoComplete extends StatelessWidget {
  final SuggestionModel suggestionModel;
  final bool isShowCodigo;
  const _ItemAutoComplete({required this.suggestionModel, required this.isShowCodigo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Row(
        children: [
          const SizedBox(width: 4),
          isShowCodigo ? _BuildSuggestionCodigo(codigo: suggestionModel.codigo) : const SizedBox(width: 8),
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
    this.details = const SizedBox(width: 1, height: 1),
    this.codigo = "",
  });
}
