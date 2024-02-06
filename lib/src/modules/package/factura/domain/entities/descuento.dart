class Descuento {
  final int codigo;
  final String tipo;
  final int valor;
  Descuento({
    required this.codigo,
    required this.tipo,
    required this.valor,
  });

  factory Descuento.fromJson(Map<String, dynamic> json) => Descuento(
        codigo: json['codigo'],
        tipo: json['tipo'],
        valor: json['valor'],
      );
}
