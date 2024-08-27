import 'package:intl/intl.dart';

String formatearMiles(String numero) {
  final double valor = double.parse(numero);
  final NumberFormat formatoMiles = NumberFormat("#,##0", "es_ES");
  return formatoMiles.format(valor);
}
