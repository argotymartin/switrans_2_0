String toTitleCase(String text) {
  final String cleanedText = text.replaceAll(' ', '').toLowerCase();

  return cleanedText.isEmpty ? cleanedText : cleanedText[0].toUpperCase() + cleanedText.substring(1);
}
