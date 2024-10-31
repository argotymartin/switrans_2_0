part of 'accion_documento_bloc.dart';

enum AccionDocumentoStatus { initial, loading, succes, error, consulted, exception }

class AccionDocumentoState extends Equatable {
  final AccionDocumentoStatus? status;
  final AccionDocumento? accionDocumento;
  final List<AccionDocumento> accionDocumentos;
  final List<EntryAutocomplete> entriesDocumentos;
  final DioException? exception;
  final String? error;
  const AccionDocumentoState({
    this.status,
    this.accionDocumento,
    this.exception,
    this.accionDocumentos = const <AccionDocumento>[],
    this.entriesDocumentos = const <EntryAutocomplete>[],
    this.error,
  });
  AccionDocumentoState initial() => const AccionDocumentoState(status: AccionDocumentoStatus.initial);

  AccionDocumentoState copyWith({
    AccionDocumentoStatus? status,
    List<EntryAutocomplete>? entriesDocumentos,
    AccionDocumento? accionDocumento,
    List<AccionDocumento>? accionDocumentos,
    DioException? exception,
    String? error,
  }) =>
      AccionDocumentoState(
        status: status ?? this.status,
        accionDocumento: accionDocumento ?? this.accionDocumento,
        accionDocumentos: accionDocumentos ?? this.accionDocumentos,
        entriesDocumentos: entriesDocumentos ?? this.entriesDocumentos,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );
  @override
  List<Object?> get props => <Object?>[status, accionDocumento, accionDocumentos, entriesDocumentos, exception, error];
}
