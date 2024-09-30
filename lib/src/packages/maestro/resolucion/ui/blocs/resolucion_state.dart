part of 'resolucion_bloc.dart';

enum ResolucionStatus { initial, loading, success, consulted, error, exception }

class ResolucionState extends Equatable {
  final ResolucionStatus? status;
  final List<Resolucion> resoluciones;
  final List<EntryAutocomplete> resolucionesDocumentos;
  final List<EntryAutocomplete> resolucionesEmpresas;
  final List<EntryAutocomplete> resolucionesCentroCosto;
  final Resolucion? resolucion;
  final DioException? exception;
  final String? error;

  const ResolucionState({
    this.status,
    this.resoluciones = const <Resolucion>[],
    this.exception,
    this.resolucionesDocumentos = const <EntryAutocomplete>[],
    this.resolucionesEmpresas = const <EntryAutocomplete>[],
    this.resolucionesCentroCosto = const <EntryAutocomplete>[],
    this.resolucion,
    this.error,
  });

  ResolucionState initial() => const ResolucionState(status: ResolucionStatus.initial);

  ResolucionState copyWith({
    ResolucionStatus? status,
    List<Resolucion>? resoluciones,
    List<EntryAutocomplete>? resolucionesDocumentos,
    List<EntryAutocomplete>? resolucionesEmpresas,
    List<EntryAutocomplete>? resolucionesCentroCosto,
    Resolucion? resolucion,
    DioException? exception,
    String? error,
  }) =>
      ResolucionState(
        status: status ?? this.status,
        resoluciones: resoluciones ?? this.resoluciones,
        exception: exception ?? this.exception,
        resolucionesDocumentos: resolucionesDocumentos ?? this.resolucionesDocumentos,
        resolucionesEmpresas: resolucionesEmpresas ?? this.resolucionesEmpresas,
        resolucionesCentroCosto: resolucionesCentroCosto ?? this.resolucionesCentroCosto,
        resolucion: resolucion ?? this.resolucion,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props =>
      <Object?>[status, resoluciones, exception, resolucionesDocumentos, resolucionesEmpresas, resolucionesCentroCosto, resolucion, error];
}
