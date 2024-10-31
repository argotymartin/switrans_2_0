part of 'departamento_bloc.dart';

enum DepartamentoStatus { initial, loading, succes, error, consulted, exception }

class DepartamentoState extends Equatable {
  final DepartamentoStatus? status;
  final Departamento? departamento;
  final List<Departamento> departamentos;
  final List<EntryAutocomplete> entriesPaises;
  final DioException? exception;
  final String error;
  const DepartamentoState({
    this.status,
    this.departamento,
    this.departamentos = const <Departamento>[],
    this.entriesPaises = const <EntryAutocomplete>[],
    this.exception,
    this.error = "",
  });
  DepartamentoState initial() => const DepartamentoState(status: DepartamentoStatus.initial);

  DepartamentoState copyWith({
    DepartamentoStatus? status,
    Departamento? departamento,
    List<Departamento>? departamentos,
    List<EntryAutocomplete>? entriesPaises,
    DioException? exception,
    String? error,
  }) =>
      DepartamentoState(
        status: status ?? this.status,
        departamento: departamento ?? this.departamento,
        departamentos: departamentos ?? this.departamentos,
        entriesPaises: entriesPaises ?? this.entriesPaises,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, departamento, departamentos, entriesPaises, exception, error];
}
