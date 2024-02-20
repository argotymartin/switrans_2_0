// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/adicion.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/descuento.dart';

class Documento {
  final int remesa;
  final String impreso;
  final String fechaCreacion;
  final int estadoCodigo;
  final String estadoNombre;
  final int empresa;
  final bool cierreTarifa;
  final int cencosCodigo;
  final String cencosNombre;
  final String tipoRemesa;
  final String origen;
  final String destino;
  final String observacion;
  final String observacionFactura;
  final String remision;
  final double rcp;
  final double total;
  final double flete;
  final bool anulacionTrafico;
  final List<Adicion> adiciones;
  final List<Descuento> descuentos;
  Documento({
    required this.remesa,
    required this.impreso,
    required this.fechaCreacion,
    required this.estadoCodigo,
    required this.estadoNombre,
    required this.empresa,
    required this.cierreTarifa,
    required this.cencosCodigo,
    required this.cencosNombre,
    required this.tipoRemesa,
    required this.origen,
    required this.destino,
    required this.observacion,
    required this.observacionFactura,
    required this.remision,
    required this.rcp,
    required this.total,
    required this.flete,
    required this.anulacionTrafico,
    required this.adiciones,
    required this.descuentos,
  });

  Map<String, dynamic> toJson() => {
        "documento": remesa,
        "tarifa": total,
      };
}
