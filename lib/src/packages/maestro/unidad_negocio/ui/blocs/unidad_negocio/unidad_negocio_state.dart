part of 'unidad_negocio_bloc.dart';

enum UnidadNegocioStatus { initial, loading, succes, error, consulted, exception }

class UnidadNegocioState extends Equatable {
  final UnidadNegocioStatus? status;
  final UnidadNegocio? unidadNegocio;
  final List<UnidadNegocio> unidadNegocios;
  final List<EntryAutocomplete> entriesEmpresa;
  final DioException? exception;
  final String? error;
  const UnidadNegocioState({
    this.status,
    this.unidadNegocio,
    this.exception,
    this.unidadNegocios = const <UnidadNegocio>[],
    this.entriesEmpresa = const <EntryAutocomplete>[],
    this.error,
  });

  UnidadNegocioState initial() => const UnidadNegocioState(status: UnidadNegocioStatus.initial);

  UnidadNegocioState copyWith({
    UnidadNegocioStatus? status,
    UnidadNegocio? unidadNegocio,
    List<UnidadNegocio>? unidadNegocios,
    List<EntryAutocomplete>? entriesEmpresa,
    DioException? exception,
    String? error,
  }) =>
      UnidadNegocioState(
        status: status ?? this.status,
        unidadNegocio: unidadNegocio ?? this.unidadNegocio,
        exception: exception ?? this.exception,
        unidadNegocios: unidadNegocios ?? this.unidadNegocios,
        entriesEmpresa: entriesEmpresa ?? this.entriesEmpresa,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[unidadNegocio, unidadNegocios, entriesEmpresa, exception, error, status];
}
