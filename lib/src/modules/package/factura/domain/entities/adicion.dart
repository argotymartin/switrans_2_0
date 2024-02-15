// ignore_for_file: public_member_api_docs, sort_constructors_first
class Adicion {
  final int codigo;
  final String tipo;
  final double valor;
  Adicion({
    required this.codigo,
    required this.tipo,
    required this.valor,
  });

  factory Adicion.fromJson(Map<String, dynamic> json) => Adicion(
        codigo: json['codigo'],
        tipo: json['tipo'],
        valor: json['valor'],
      );
}
