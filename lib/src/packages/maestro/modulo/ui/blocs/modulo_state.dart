part of 'modulo_bloc.dart';

enum ModuloStatus { initial, loading, loaded, succes, error, consulted, exception }

class ModuloState extends Equatable {
  final ModuloStatus? status;
  final Modulo? modulo;
  final List<Modulo> modulos;
  final List<EntryAutocomplete> entriesPaquete;
  final DioException? exception;
  final String? error;
  const ModuloState({
    this.status,
    this.modulo,
    this.exception,
    this.modulos = const <Modulo>[],
    this.entriesPaquete = const <EntryAutocomplete>[],
    this.error,
  });

  ModuloState initial() => const ModuloState(status: ModuloStatus.initial);

  ModuloState copyWith({
    ModuloStatus? status,
    Modulo? modulo,
    List<Modulo>? modulos,
    List<EntryAutocomplete>? entriesPaquete,
    DioException? exception,
    String? error,
  }) =>
      ModuloState(
        status: status ?? this.status,
        modulo: modulo ?? this.modulo,
        exception: exception ?? this.exception,
        modulos: modulos ?? this.modulos,
        entriesPaquete: entriesPaquete ?? this.entriesPaquete,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[modulo, modulos, entriesPaquete, exception, error, status];
}
