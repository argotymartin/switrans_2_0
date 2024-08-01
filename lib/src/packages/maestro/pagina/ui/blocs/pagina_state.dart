part of 'pagina_bloc.dart';

enum PaginaStatus { initial, loading, succes, error, consulted, exception }

class PaginaState extends Equatable {
  final PaginaStatus? status;
  final Pagina? pagina;
  final List<Pagina> paginas;
  final List<EntryAutocomplete> entriesModulos;
  final DioException? exception;
  final String error;
  const PaginaState({
    this.status,
    this.pagina,
    this.exception,
    this.paginas = const <Pagina>[],
    this.entriesModulos = const <EntryAutocomplete>[],
    this.error = "",
  });
  PaginaState initial() => const PaginaState(status: PaginaStatus.initial);

  PaginaState copyWith({
    PaginaStatus? status,
    Pagina? pagina,
    List<Pagina>? paginas,
    List<EntryAutocomplete>? entriesModulos,
    DioException? exception,
    String? error,
  }) =>
      PaginaState(
        status: status ?? this.status,
        pagina: pagina ?? this.pagina,
        exception: exception ?? this.exception,
        paginas: paginas ?? this.paginas,
        entriesModulos: entriesModulos ?? this.entriesModulos,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, pagina, exception, paginas, entriesModulos, error];
}
