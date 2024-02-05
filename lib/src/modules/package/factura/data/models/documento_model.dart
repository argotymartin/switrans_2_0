import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';

class DocumentoModel extends Documento {
  DocumentoModel({
    required super.remesa,
    required super.impreso,
    required super.fechaCreacion,
    required super.estadoCodigo,
    required super.estadoNombre,
    required super.empresa,
    required super.cierreTarifa,
    required super.cencosCodigo,
    required super.cencosNombre,
    required super.tipoRemesa,
    required super.origen,
    required super.destino,
    required super.observacion,
    required super.observacionFactura,
    required super.remision,
    required super.rcp,
    required super.total,
    required super.flete,
    required super.anulacionTrafico,
  });

  factory DocumentoModel.fromJson(Map<String, dynamic> json) => DocumentoModel(
        remesa: json['remesa'],
        impreso: json['impreso'],
        fechaCreacion: json['fechaCreacion'],
        estadoCodigo: json['estadoCodigo'],
        estadoNombre: json['estadoNombre'],
        empresa: json['empresa'],
        cierreTarifa: json['cierreTarifa'],
        cencosCodigo: json['cencosCodigo'],
        cencosNombre: json['cencosNombre'],
        tipoRemesa: json['tipoRemesa'],
        origen: json['origen'],
        destino: json['destino'],
        observacion: json['observacion'],
        observacionFactura: json['observacionFactura'],
        remision: json['remision'],
        rcp: json['rcp'],
        total: json['total'],
        flete: json['flete'],
        anulacionTrafico: json['anulacionTrafico'],
      );
}
