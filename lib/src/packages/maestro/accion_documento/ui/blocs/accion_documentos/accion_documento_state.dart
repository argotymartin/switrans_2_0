part of 'accion_documento_bloc.dart';

enum AccionDocumentoStatus { initial, loading, succes, error, consulted, exception }

class AccionDocumentoState extends Equatable {
  final AccionDocumentoStatus? status;
  final List<EntryAutocomplete> entriesTiposDocumento;
  final AccionDocumento? accionDocumento;
  final List<AccionDocumento> accionDocumentos;
  final DioException? exception;
  final String? error;

  const AccionDocumentoState({
    this.status,
    this.accionDocumento,
    this.exception,
    this.accionDocumentos = const <AccionDocumento>[],
    this.error,
    this.entriesTiposDocumento = const <EntryAutocomplete>[],
  });
  AccionDocumentoState initial() => const AccionDocumentoState(status: AccionDocumentoStatus.initial);

  AccionDocumentoState copyWith({
    AccionDocumentoStatus? status,
    List<EntryAutocomplete>? entriesTiposDocumento,
    AccionDocumento? accionDocumento,
    List<AccionDocumento>? accionDocumentos,
    DioException? exception,
    String? error,
  }) =>
      AccionDocumentoState(
        status: status ?? this.status,
        entriesTiposDocumento: entriesTiposDocumento ?? this.entriesTiposDocumento,
        accionDocumento: accionDocumento ?? this.accionDocumento,
        accionDocumentos: accionDocumentos ?? this.accionDocumentos,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );
  @override
  List<Object?> get props => <Object?>[status, entriesTiposDocumento, accionDocumento, exception, accionDocumentos, error];
}
