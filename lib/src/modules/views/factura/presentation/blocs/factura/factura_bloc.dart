import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/repositories/abstract_factura_repository.dart';

part 'factura_event.dart';
part 'factura_state.dart';

class FacturaBloc extends Bloc<FacturaEvent, FacturaState> {
  final AbstractFacturaRepository _repository;
  FacturaBloc(this._repository) : super(FacturaInitial()) {
    on<FacturaEvent>((event, emit) {});
  }
  Future<List<Cliente>> getCliente(String name) async {
    final dataState = await _repository.getCliente(name);
    return dataState.data!;
  }

  Future<List<Cliente>> getClientesAll() async {
    final dataState = await _repository.getClientes();
    return dataState.data!;
  }

  Future<List<Empresa>> getEmpresas() async {
    final dataState = await _repository.getEmpresasService();
    return dataState.data!;
  }
}
