import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';

part 'accion_documento_event.dart';
part 'accion_documento_state.dart';

class AccionDocumentoBloc extends Bloc<AccionDocumentoEvent, AccionDocumentoState> {
  final AbstractAccionDocumentoRepository _repository;
  List<TipoDocumentoAccionDocumento> tipos = [];
  AccionDocumentoBloc(this._repository) : super(const AccionDocumentoInitialState()) {
    on<SetAccionDocumentoEvent>((event, emit) async {
      emit(const AccionDocumentoLoadingState());
      final resp = await _repository.setAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoSuccesState(accionDocumento: resp.data));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<UpdateAccionDocumentoEvent>((event, emit) async {
      emit(const AccionDocumentoLoadingState());
      final resp = await _repository.updateAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoSuccesState(accionDocumento: resp.data));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<GetAccionDocumentoEvent>((event, emit) async {
      emit(const AccionDocumentoLoadingState());
      final resp = await _repository.getAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoConsultedState(accionDocumentos: resp.data!));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<ErrorFormAccionDocumentoEvent>((event, emit) async {
      emit(const AccionDocumentoLoadingState());
      emit(AccionDocumentoErrorFormState(error: event.error));
    });
  }

  Future<void> onGetTipoDocumento() async {
    if (tipos.isEmpty) {
      final resp = await _repository.getTipoDocumentosService();
      tipos = resp.data!;
    }
  }
}
