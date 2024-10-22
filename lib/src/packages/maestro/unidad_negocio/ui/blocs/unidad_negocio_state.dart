part of 'unidad_negocio_bloc.dart';

enum UnidadNegocioStatus { initial, loading, succes, error, consulted, exception }

class UnidadNegocioState extends Equatable {
  final UnidadNegocioStatus? status;
  final UnidadNegocio? unidadNegocio;
  final List<UnidadNegocio> unidadNegocios;
  final List<EntryAutocomplete> entriesEmpresas;
  final DioException? exception;
  final String? error;
  const UnidadNegocioState({
    this.status,
    this.unidadNegocio,
    this.unidadNegocios = const <UnidadNegocio>[],
    this.entriesEmpresas = const <EntryAutocomplete>[],
    this.exception,
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
        unidadNegocios: unidadNegocios ?? this.unidadNegocios,
        entriesEmpresas: entriesEmpresa ?? this.entriesEmpresas,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, unidadNegocio, unidadNegocios, entriesEmpresas, exception, error ];
}
