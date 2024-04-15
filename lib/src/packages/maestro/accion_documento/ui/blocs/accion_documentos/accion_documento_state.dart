part of 'accion_documento_bloc.dart';

sealed class AccionDocumentoState extends Equatable {
  final AccionDocumento? accionDocumento;
  final List<AccionDocumento> accionDocumentos;
  final List<TipoDocumentoAccionDocumento> tipoDocumentos;
  final DioException? exception;
  final String? error;
  const AccionDocumentoState(
      {this.accionDocumento, this.exception, this.accionDocumentos = const [], this.tipoDocumentos = const [], this.error});
}

class AccionDocumentoInitialState extends AccionDocumentoState {
  const AccionDocumentoInitialState();

  @override
  List<Object> get props => [];
}

class AccionDocumentoLoadingState extends AccionDocumentoState {
  const AccionDocumentoLoadingState();

  @override
  List<Object> get props => [];
}

class AccionDocumentoSuccesState extends AccionDocumentoState {
  const AccionDocumentoSuccesState({super.accionDocumento});

  @override
  List<Object> get props => [accionDocumento!];
}

class AccionDocumentoConsultedState extends AccionDocumentoState {
  const AccionDocumentoConsultedState({super.accionDocumentos});

  @override
  List<Object> get props => [accionDocumentos];
}

class AccionDocumentoExceptionState extends AccionDocumentoState {
  const AccionDocumentoExceptionState({super.exception});
  @override
  List<Object> get props => [exception!];
}

class AccionDocumentoErrorFormState extends AccionDocumentoState {
  const AccionDocumentoErrorFormState({super.error});
  @override
  List<Object> get props => [error!];
}
