import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'accion_documento_event.dart';
part 'accion_documento_state.dart';

class AccionDocumentoBloc extends Bloc<AccionDocumentoEvent, AccionDocumentoState> {
  AccionDocumentoRequest _request = AccionDocumentoRequest();

  final AbstractAccionDocumentoRepository _repository;
  AccionDocumentoBloc(this._repository) : super(const AccionDocumentoState().initial()) {
    on<InitializationAccionDocumentoEvent>(_onInitializationAccionDocumento);
    on<GetAccionDocumentoEvent>(_onGetAccionDocumento);
    on<SetAccionDocumentoEvent>(_onSetAccionDocumento);
    on<UpdateAccionDocumentoEvent>(_onUpdateAccionDocumento);
    on<ErrorFormAccionDocumentoEvent>(_onErrorAccionDocumento);
    on<CleanFormAccionDocumentoEvent>(_onCleanFormAccionDocumento);
  }

  Future<void> _onInitializationAccionDocumento(InitializationAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<List<TipoDocumentoAccionDocumento>> resp = await _repository.getTipoDocumentosService();
    if (resp.data != null) {
      final List<EntryAutocomplete> entryMenus = resp.data!
          .map(
            (TipoDocumentoAccionDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo),
          )
          .toList();
      emit(state.copyWith(status: AccionDocumentoStatus.initial, entriesTiposDocumento: entryMenus));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: resp.error!));
    }
  }

  Future<void> _onGetAccionDocumento(GetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<List<AccionDocumento>> resp = await _repository.getAccionDocumentosService(event.request);
    if (resp.data != null) {
      emit(state.copyWith(status: AccionDocumentoStatus.consulted, accionDocumentos: resp.data));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: resp.error!));
    }
  }

  Future<void> _onSetAccionDocumento(SetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(state.copyWith(status: AccionDocumentoStatus.loading));
    final DataState<AccionDocumento> resp = await _repository.setAccionDocumentosService(event.request);
    if (resp.data != null) {
      emit(state.copyWith(status: AccionDocumentoStatus.succes, accionDocumento: resp.data));
    } else {
      emit(state.copyWith(status: AccionDocumentoStatus.exception, exception: resp.error!));
    }
  }

  Future<void> _onUpdateAccionDocumento(UpdateAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
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
