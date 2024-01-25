part of 'filters_factura_bloc.dart';

sealed class FiltersFacturaState extends Equatable {
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  const FiltersFacturaState({this.clientes = const [], this.empresas = const []});

  @override
  List<Object> get props => [];
}

final class FiltersFacturaInitial extends FiltersFacturaState {}

class FiltersFacturaInitialState extends FiltersFacturaState {
  const FiltersFacturaInitialState({super.clientes, super.empresas});

  @override
  List<Object> get props => [];
}

class FiltersFacturaLoadingState extends FiltersFacturaState {
  const FiltersFacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FiltersFacturaSuccesState extends FiltersFacturaState {
  const FiltersFacturaSuccesState();

  @override
  List<Object> get props => [];
}

class FiltersFacturaErrorState extends FiltersFacturaState {
  final DioException error;

  const FiltersFacturaErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
