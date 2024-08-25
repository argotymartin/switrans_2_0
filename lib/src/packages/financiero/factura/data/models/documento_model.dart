import 'package:switrans_2_0/src/packages/financiero/factura/data/models/adicion_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/descuento_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/data/models/impuesto_model.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

class DocumentoModel extends Documento {
  DocumentoModel({
    required super.documento,
    required super.impreso,
    required super.centroCostoCodigo,
    required super.centroCostoNombre,
    required super.tipoDocumentoCodigo,
    required super.tipoDocumentoNombre,
    required super.origen,
    required super.destino,
    required super.descripcion,
    required super.datosAdicionales,
    required super.valorEgreso,
    required super.valorIngreso,
    required super.valorTotal,
    required super.adiciones,
    required super.descuentos,
    required super.impuestos,
  });

  factory DocumentoModel.fromJson(Map<String, dynamic> json) => DocumentoModel(
        documento: json['documento'],
        impreso: json['documentoImpreso'],
        centroCostoCodigo: json['centroCostoCodigo'],
        centroCostoNombre: json['centroCostoNombre'],
        tipoDocumentoCodigo: json['tipoDocumentoCodigo'] ?? '',
        tipoDocumentoNombre: json['tipoDocumentoNombre'] ?? '',
        origen: json['origen'] ?? '',
        destino: json['destino'] ?? '',
        descripcion: json['descripcion'],
        datosAdicionales: json['datosAdicionales'],
        valorEgreso: json['valorEgreso'],
        valorIngreso: json['valorIngreso'],
        valorTotal: json['valorTotal'],
        adiciones: List<Adicion>.from(json["adiciones"].map((dynamic x) => AdicionModel.fromJson(x))),
        descuentos: List<Descuento>.from(json["descuentos"].map((dynamic x) => DescuentoModel.fromJson(x))),
        impuestos: List<Impuesto>.from(json["impuestosTotales"].map((dynamic x) => ImpuestoModel.fromJson(x))),
      );
}
