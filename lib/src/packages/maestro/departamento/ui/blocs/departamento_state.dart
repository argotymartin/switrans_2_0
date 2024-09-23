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
    this.exception,
    this.departamentos = const <Departamento>[],
    this.entriesPaises = const <EntryAutocomplete>[],
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
        exception: exception ?? this.exception,
        departamentos: departamentos ?? this.departamentos,
        entriesPaises: entriesPaises ?? this.entriesPaises,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[departamento, departamentos, departamentos, entriesPaises, exception, error, status];
}
