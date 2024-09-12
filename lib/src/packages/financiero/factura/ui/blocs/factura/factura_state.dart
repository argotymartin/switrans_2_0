part of 'factura_bloc.dart';

enum FacturaStatus { initial, loading, succes, error, consulted, exception, facturar }

class FacturaState extends Equatable {
  final FacturaStatus? status;
  final int empresa;
  final int tipoFactura;
  final String error;
  final List<Empresa> empresas;
  final List<EntryAutocomplete> entriesTiposDocumentos;
  final List<EntryAutocomplete> entriesClientes;
  final DioException? exception;
  final List<Documento> documentos;
  final List<Documento> documentosSelected;

  const FacturaState({
    this.empresa = 1,
    this.status,
    this.tipoFactura = 10,
    this.error = "",
    this.entriesClientes = const <EntryAutocomplete>[],
    this.empresas = const <Empresa>[],
    this.entriesTiposDocumentos = const <EntryAutocomplete>[],
    this.documentos = const <Documento>[],
    this.documentosSelected = const <Documento>[],
    this.exception,
  });

  FacturaState initial() => const FacturaState(status: FacturaStatus.initial);

  FacturaState copyWith({
    FacturaStatus? status,
    int? empresa,
    int? tipoFactura,
    String? error,
    List<Empresa>? empresas,
    List<EntryAutocomplete>? entriesTiposDocumentos,
    List<EntryAutocomplete>? entriesClientes,
    DioException? exception,
    List<Documento>? documentos,
    List<Documento>? documentosSelected,
  }) =>
      FacturaState(
        status: status ?? this.status,
        empresa: empresa ?? this.empresa,
        tipoFactura: tipoFactura ?? this.tipoFactura,
        error: error ?? this.error,
        entriesClientes: entriesClientes ?? this.entriesClientes,
        empresas: empresas ?? this.empresas,
        entriesTiposDocumentos: entriesTiposDocumentos ?? this.entriesTiposDocumentos,
        exception: exception ?? this.exception,
        documentos: documentos ?? this.documentos,
        documentosSelected: documentosSelected ?? this.documentosSelected,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        empresa,
        tipoFactura,
        error,
        entriesClientes,
        empresas,
        entriesTiposDocumentos,
        documentos,
        exception,
        documentosSelected,
      ];
}
