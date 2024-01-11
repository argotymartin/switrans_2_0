part of 'factura_bloc.dart';

sealed class FacturaState extends Equatable {
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  const FacturaState({this.clientes = const [], this.empresas = const []});

  @override
  List<Object> get props => [];
}

final class FacturaInitial extends FacturaState {}

class FacturaInitialState extends FacturaState {
  const FacturaInitialState();

  @override
  List<Object> get props => [];
}

class FacturaLoadingState extends FacturaState {
  const FacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FacturaSuccesState extends FacturaState {
  const FacturaSuccesState({super.clientes});

  @override
  List<Object> get props => [];
}

class FacturaErrorState extends FacturaState {
  final Exception error;

  const FacturaErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
