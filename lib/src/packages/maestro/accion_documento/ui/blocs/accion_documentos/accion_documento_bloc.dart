import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/accion_documento_domain.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/tipo_documento_accion_documento.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'accion_documento_event.dart';
part 'accion_documento_state.dart';

class AccionDocumentoBloc extends Bloc<AccionDocumentoEvent, AccionDocumentoState> {
  AccionDocumentoRequest _request = AccionDocumentoRequest();
  List<EntryAutocomplete> _entriesTiposDocumento = <EntryAutocomplete>[];

  final AbstractAccionDocumentoRepository _repository;
  AccionDocumentoBloc(this._repository) : super(const AccionDocumentoInitialState()) {
    on<InitializationAccionDocumentoEvent>(_onInitializationAccionDocumento);
    on<GetAccionDocumentoEvent>(_onGetAccionDocumento);
    on<SetAccionDocumentoEvent>(_onSetAccionDocumento);
    on<UpdateAccionDocumentoEvent>(_onUpdateAccionDocumento);
    on<ErrorFormAccionDocumentoEvent>(_onErrorAccionDocumento);
    on<CleanFormAccionDocumentoEvent>(_onCleanFormAccionDocumento);
  }

  Future<void> _onInitializationAccionDocumento(InitializationAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(const AccionDocumentoLoadingState());
    final DataState<List<TipoDocumentoAccionDocumento>> resp = await _repository.getTipoDocumentosService();
    if (resp.data != null) {
      final List<TipoDocumentoAccionDocumento> acciones = resp.data!;
      final List<EntryAutocomplete> entryMenus = acciones
          .map(
            (TipoDocumentoAccionDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo),
          )
          .toList();
      entriesTiposDocumento = entryMenus;
      emit(const AccionDocumentoInitialState());
    } else {
      emit(AccionDocumentoExceptionState(exception: resp.error));
    }
  }

  Future<void> _onGetAccionDocumento(GetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(const AccionDocumentoLoadingState());
    final DataState<List<AccionDocumento>> resp = await _repository.getAccionDocumentosService(request);
    if (resp.data != null) {
      emit(AccionDocumentoConsultedState(accionDocumentos: resp.data!));
    } else {
      emit(AccionDocumentoExceptionState(exception: resp.error));
    }
  }

  Future<void> _onSetAccionDocumento(SetAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(const AccionDocumentoLoadingState());
    final DataState<AccionDocumento> resp = await _repository.setAccionDocumentosService(event.request);
    if (resp.data != null) {
      emit(AccionDocumentoSuccesState(accionDocumento: resp.data));
    } else {
      emit(AccionDocumentoExceptionState(exception: resp.error));
    }
  }

  Future<void> _onUpdateAccionDocumento(UpdateAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(const AccionDocumentoLoadingState());
    final List<DataState<AccionDocumento>> dataStateList = await Future.wait(
      event.requestList.map((AccionDocumentoRequest request) => _repository.updateAccionDocumentosService(request)),
    );
    final List<AccionDocumento> accionesDocumentoList = dataStateList.map((DataState<AccionDocumento> e) => e.data!).toList();
    if (accionesDocumentoList.isNotEmpty) {
      emit(AccionDocumentoConsultedState(accionDocumentos: accionesDocumentoList));
    }

    final List<DioException> exceptionList = dataStateList.map((DataState<AccionDocumento> e) => e.error!).toList();
    if (exceptionList.isNotEmpty) {
      for (final DioException exception in exceptionList) {
        emit(const AccionDocumentoLoadingState());
        emit(AccionDocumentoExceptionState(exception: exception));
      }
    }
  }

  Future<void> _onErrorAccionDocumento(ErrorFormAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    emit(const AccionDocumentoLoadingState());
    emit(AccionDocumentoErrorFormState(error: event.error));
  }

  Future<void> _onCleanFormAccionDocumento(CleanFormAccionDocumentoEvent event, Emitter<AccionDocumentoState> emit) async {
    request.clean();
    emit(const AccionDocumentoInitialState());
  }

  AccionDocumentoRequest get request => _request;
  set request(AccionDocumentoRequest value) => _request = value;

  List<EntryAutocomplete> get entriesTiposDocumento => _entriesTiposDocumento;
  set entriesTiposDocumento(List<EntryAutocomplete> value) => _entriesTiposDocumento = value;
}
