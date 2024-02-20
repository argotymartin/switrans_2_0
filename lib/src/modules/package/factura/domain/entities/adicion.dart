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
