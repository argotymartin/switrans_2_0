part of 'municipio_bloc.dart';

enum MunicipioStatus { initial, loading, succes, error, consulted, exception }

class MunicipioState extends Equatable {
  final MunicipioStatus? status;
  final Municipio? municipio;
  final List<Municipio> municipios;
  final List<EntryAutocomplete> municipioDepartamentos;
  final List<EntryAutocomplete> municipioPaises;
  final DioException? exception;
  final String error;
  final String? nombre;

  const MunicipioState({
    this.status,
    this.municipio,
    this.municipios = const <Municipio>[],
    this.municipioDepartamentos = const <EntryAutocomplete>[],
    this.municipioPaises = const <EntryAutocomplete>[],
    this.exception,
    this.error = "",
    this.nombre,
  });

  MunicipioState initial() => const MunicipioState(status: MunicipioStatus.initial);

  MunicipioState copyWith({
    MunicipioStatus? status,
    Municipio? municipio,
    List<Municipio>? municipios,
    List<EntryAutocomplete>? municipioDepartamentos,
    List<EntryAutocomplete>? municipioPaises,
    DioException? exception,
    String? error,
    String? nombre,
  }) =>
      MunicipioState(
        status: status ?? this.status,
        municipio: municipio ?? this.municipio,
        municipios: municipios ?? this.municipios,
        municipioDepartamentos: municipioDepartamentos ?? this.municipioDepartamentos,
        municipioPaises: municipioPaises ?? this.municipioPaises,
        exception: exception ?? this.exception,
        error: error ?? this.error,
        nombre: nombre ?? this.nombre,
      );

  @override
  List<Object?> get props => <Object?>[
    status,
    municipio,
    municipios,
    municipioDepartamentos,
    municipioPaises,
    exception,
    error,
    nombre,
  ];
}
