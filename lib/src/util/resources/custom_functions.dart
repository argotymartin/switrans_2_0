class CustomFunctions {
  static String limpiarTexto(String texto) {
    return texto.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}
