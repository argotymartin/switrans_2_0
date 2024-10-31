import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/resources/entity_update.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'accion_documento_event.dart';
part 'accion_documento_state.dart';

class AccionDocumentoBloc extends Bloc<AccionDocumentoEvent, AccionDocumentoState> {
  final AbstractAccionDocumentoRepository _repository;
  AccionDocumentoRequest _request = AccionDocumentoRequest();

  AccionDocumentoBloc(this._repository) : super(const AccionDocumentoState().initial()) {
    on<InitialAccionDocumentoEvent>(_onInitialAccionDocumento);
    on<GetAccionDocumentosEvent>(_onGetAccionDocumentos);
    on<SetAccionDocumentoEvent>(_onSetAccionDocumento);
    on<UpdateAccionDocumentosEvent>(_onUpdateAccionDocumentos);
    on<ErrorFormAccionDocumentoEvent>(_onErrorAccionDocumento);
    on<CleanFormAccionDocumentoEvent>(_onCleanFormAccionDocumento);
  }

  Future<void> _onInitialAccionDocumento(InitialAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<List<AccionDocumentoDocumento>> resp = await _repository.getDocumentosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entriesDocumentos =
          resp.data!.map((AccionDocumentoDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(state.copyWith(status: AccionDocumentoStatus.initial, entriesDocumentos: entriesDocumentos));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: resp.error!));
    }
  }

  Future<void> _onGetAccionDocumentos(GetAccionDocumentosEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<List<AccionDocumento>> response = await _repository.getAccionDocumentosService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: AccionDocumentoStatus.consulted, accionDocumentos: response.data));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetAccionDocumento(SetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<AccionDocumento> response = await _repository.setAccionDocumentoService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: AccionDocumentoStatus.succes, accionDocumento: response.data));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: response.error));
    }
  }

  Future<void> _onUpdateAccionDocumentos(UpdateAccionDocumentosEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));

    final List<DataState<AccionDocumento>> dataStateList = await Future.wait(
      event.requestList.map((EntityUpdate<AccionDocumentoRequest> request) => _repository.updateAccionDocumentosService(request)),
    );

    final List<AccionDocumento> accionDocumentos = <AccionDocumento>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<AccionDocumento> dataState in dataStateList) {
      if (dataState.data != null) {
        accionDocumentos.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (accionDocumentos.isNotEmpty) {
      emit(state.copyWith(status: AccionDocumentoStatus.consulted, accionDocumentos: accionDocumentos));
    }

    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorAccionDocumento(ErrorFormAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.error, error: event.error));
  }

  Future<void> _onCleanFormAccionDocumento(CleanFormAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    request.clean();
    emit(state.copyWith(status: AccionDocumentoStatus.initial, accionDocumentos: <AccionDocumento>[], error: ""));
  }

  AccionDocumentoRequest get request => _request;
  set request(AccionDocumentoRequest value) => _request = value;
}
