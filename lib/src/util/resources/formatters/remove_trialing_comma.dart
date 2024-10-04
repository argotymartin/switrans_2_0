String removeTrailingComma(String text) {
  final String inputString;
  if (text.endsWith(',')) {
    inputString = text.substring(0, text.length - 1);
  } else {
    inputString = text;
  }

  return inputString;
}
