import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'accion_documento_event.dart';
part 'accion_documento_state.dart';

class AccionDocumentoBloc extends Bloc<AccionDocumentoEvent, AccionDocumentoState> {
  final AbstractAccionDocumentoRepository _repository;
  List<TipoDocumentoAccionDocumento> tipos = <TipoDocumentoAccionDocumento>[];
  AccionDocumentoBloc(this._repository) : super(const AccionDocumentoInitialState()) {
    on<SetAccionDocumentoEvent>((SetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
      emit(const AccionDocumentoLoadingState());
      final DataState<AccionDocumento> resp = await _repository.setAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoSuccesState(accionDocumento: resp.data));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<UpdateAccionDocumentoEvent>((UpdateAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
      emit(const AccionDocumentoLoadingState());
      final DataState<AccionDocumento> resp = await _repository.updateAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoSuccesState(accionDocumento: resp.data));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<GetAccionDocumentoEvent>((GetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
      emit(const AccionDocumentoLoadingState());
      final DataState<List<AccionDocumento>> resp = await _repository.getAccionDocumentosService(event.request);
      if (resp.data != null) {
        emit(AccionDocumentoConsultedState(accionDocumentos: resp.data!));
      } else {
        emit(AccionDocumentoExceptionState(exception: resp.error));
      }
    });

    on<ErrorFormAccionDocumentoEvent>((ErrorFormAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
      emit(const AccionDocumentoLoadingState());
      emit(AccionDocumentoErrorFormState(error: event.error));
    });
  }

  Future<void> onGetTipoDocumento() async {
    if (tipos.isEmpty) {
      final DataState<List<TipoDocumentoAccionDocumento>> resp = await _repository.getTipoDocumentosService();
      tipos = resp.data!;
    }
  }
}
