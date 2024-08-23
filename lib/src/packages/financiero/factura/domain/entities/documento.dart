import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/adicion.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/descuento.dart';

class Documento {
  final int documento;
  final String impreso;
  final int centroCostoCodigo;
  final String centroCostoNombre;
  final int tipoDocumentoCodigo;
  final String tipoDocumentoNombre;
  final String origen;
  final String destino;
  final String descripcion;
  final String datosAdicionales;
  final double valorEgreso;
  final double valorIngreso;
  final double valorTotal;
  final List<Adicion> adiciones;
  final List<Descuento> descuentos;

  Documento({
    required this.documento,
    required this.impreso,
    required this.centroCostoCodigo,
    required this.centroCostoNombre,
    required this.tipoDocumentoCodigo,
    required this.tipoDocumentoNombre,
    required this.origen,
    required this.destino,
    required this.descripcion,
    required this.datosAdicionales,
    required this.valorEgreso,
    required this.valorIngreso,
    required this.valorTotal,
    required this.adiciones,
    required this.descuentos,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "documento": documento,
      };
}
