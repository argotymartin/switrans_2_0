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
  ServicioEmpresarialBloc(this._repository) : super(const ServicioEmpresarialInitialState()) {
    on<GetServicioEmpresarialEvent>((GetServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
      emit(const ServicioEmpresarialLoadingState());
      final DataState<List<ServicioEmpresarial>> resp = await _repository.getServicioEmpresarialService(event.request);
      if (resp.data != null) {
        emit(ServicioEmpresarialConsultedState(serviciosEmpresariales: resp.data!));
      } else {
        emit(ServicioEmpresarialExceptionState(exception: resp.error!));
      }
    });

    on<UpdateServicioEmpresarialEvent>((UpdateServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
      emit(const ServicioEmpresarialLoadingState());
      final DataState<ServicioEmpresarial> resp = await _repository.updateServicioEmpresarialService(event.request);
      if (resp.data != null) {
        emit(ServicioEmpresarialSuccesState(servicioEmpresarial: resp.data));
      } else {
        emit(ServicioEmpresarialExceptionState(exception: resp.error!));
      }
    });

    on<SetServicioEmpresarialEvent>((SetServicioEmpresarialEvent event, Emitter<ServicioEmpresarialState> emit) async {
      emit(const ServicioEmpresarialLoadingState());
      final DataState<ServicioEmpresarial> resp = await _repository.setServicioEmpresarialService(event.request);
      if (resp.data != null) {
        emit(ServicioEmpresarialSuccesState(servicioEmpresarial: resp.data));
      } else {
        emit(ServicioEmpresarialExceptionState(exception: resp.error!));
      }
    });
  }
}
