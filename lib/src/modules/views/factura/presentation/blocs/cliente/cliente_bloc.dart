import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/repositories/abstract_cliente_repository.dart';

part 'cliente_event.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final AbstractClienteRepository _repository;
  ClienteBloc(this._repository) : super(ClienteInitial()) {
    on<ClienteEvent>((event, emit) {});
    on<ActiveteClienteEvent>((event, emit) async {
      emit(const ClienteLoadingState());
      final dataState = await _repository.getCliente(event.cliente);
      emit(ClienteSuccesState(clientes: dataState.data!));
    });
  }
}
