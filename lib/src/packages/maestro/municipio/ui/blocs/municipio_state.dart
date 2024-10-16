part of 'municipio_bloc.dart';

enum MunicipioStatus { initial, loading, succes, error, consulted, exception }

class MunicipioState extends Equatable {
  final MunicipioStatus? status;
  final Municipio? municipio;
  final List<Municipio> municipios;
  final List<EntryAutocomplete> entriesDepartamentos;
  final DioException? exception;
  final String error;
  const MunicipioState({
    this.status,
    this.municipio,
    this.municipios = const <Municipio>[],
    this.entriesDepartamentos = const <EntryAutocomplete>[],
    this.exception,
    this.error = "",
  });
  MunicipioState initial() => const MunicipioState(status: MunicipioStatus.initial);

  MunicipioState copyWith({
    MunicipioStatus? status,
    Municipio? municipio,
    List<Municipio>? municipios,
    List<EntryAutocomplete>? entriesDepartamentos,
    DioException? exception,
    String? error,
  }) =>
      MunicipioState(
        status: status ?? this.status,
        municipio: municipio ?? this.municipio,
        municipios: municipios ?? this.municipios,
        entriesDepartamentos: entriesDepartamentos ?? this.entriesDepartamentos,
        exception: exception ?? this.exception,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, municipio, municipios, entriesDepartamentos, exception, error];
}
