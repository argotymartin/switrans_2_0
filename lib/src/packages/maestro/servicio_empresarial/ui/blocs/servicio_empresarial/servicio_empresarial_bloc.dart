import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/servicio_empresarial.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/repositories/abstract_servicio_empresarial_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'servicio_empresarial_event.dart';
part 'servicio_empresarial_state.dart';

class ServicioEmpresarialBloc extends Bloc<ServicioEmpresarialEvent, ServicioEmpresarialState> {
  final AbstractServicioEmpresarialRepository _repository;
  ServicioEmpresarialRequest _request = ServicioEmpresarialRequest();

  ServicioEmpresarialBloc(this._repository) : super(const ServicioEmpresarialState().initial()) {
    on<InitializationServicioEmpresarialEvent>(_onInitializationServicioEmpresarial);
    on<GetServicioEmpresarialEvent>(_onGetServicioEmpresarial);
    on<SetServicioEmpresarialEvent>(_onSetServicioEmpresarial);
    on<UpdateServicioEmpresarialEvent>(_onUpdateServicioEmpresarial);
    on<ErrorFormServicioEmpresarialEvent>(_onErrorFormServicioEmpresarial);
    on<CleanFormServicioEmpresarialEvent>(_onCleanFormServicioEmpresarial);
  }

  Future<void> _onInitializationServicioEmpresarial(
    InitializationServicioEmpresarialEvent event,
    Emitter<ServicioEmpresarialState> emit,
  ) async {
    request.clean();
    emit(state.copyWith(status: ServicioEmpresarialStatus.initial));
  }

  Future<void> _onGetServicioEmpresarial(GetServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
    emit(state.copyWith(status: ServicioEmpresarialStatus.loading));
    final DataState<List<ServicioEmpresarial>> response = await _repository.getServicioEmpresarialService(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: ServicioEmpresarialStatus.consulted, serviciosEmpresariales: response.data));
    } else {
      emit(state.copyWith(status: ServicioEmpresarialStatus.exception, exception: response.error));
    }
  }

  Future<void> _onSetServicioEmpresarial(SetServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
    emit(state.copyWith(status: ServicioEmpresarialStatus.loading));
    final DataState<ServicioEmpresarial> resp = await _repository.setServicioEmpresarialService(event.request);
    if (resp.data != null) {
      emit(state.copyWith(status: ServicioEmpresarialStatus.succes, servicioEmpresarial: resp.data));
    } else {
      emit(state.copyWith(status: ServicioEmpresarialStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onUpdateServicioEmpresarial(UpdateServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
    emit(state.copyWith(status: ServicioEmpresarialStatus.loading));
    final List<DataState<ServicioEmpresarial>> dataStateList = await Future.wait(
      event.requestList.map((ServicioEmpresarialRequest request) => _repository.updateServicioEmpresarialService(request)),
    );

    final List<ServicioEmpresarial> serviciosEmpresariales = <ServicioEmpresarial>[];
    final List<DioException> exceptions = <DioException>[];

    for (final DataState<ServicioEmpresarial> dataState in dataStateList) {
      if (dataState.data != null) {
        serviciosEmpresariales.add(dataState.data!);
      } else if (dataState.error != null) {
        exceptions.add(dataState.error!);
      }
    }

    if (serviciosEmpresariales.isNotEmpty) {
      emit(state.copyWith(status: ServicioEmpresarialStatus.succes, serviciosEmpresariales: serviciosEmpresariales));
    }
    if (exceptions.isNotEmpty) {
      for (final DioException exception in exceptions) {
        emit(state.copyWith(status: ServicioEmpresarialStatus.exception, exception: exception));
      }
    }
  }

  Future<void> _onErrorFormServicioEmpresarial(ErrorFormServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
    emit(state.copyWith(status: ServicioEmpresarialStatus.error, error: event.error));
  }

  Future<void> _onCleanFormServicioEmpresarial(CleanFormServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
    request.clean();
    emit(state.copyWith(status: ServicioEmpresarialStatus.initial, serviciosEmpresariales: <ServicioEmpresarial>[], error: ''));
  }

  ServicioEmpresarialRequest get request => _request;
  set request(ServicioEmpresarialRequest request) => _request = request;
}
