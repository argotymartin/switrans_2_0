part of 'filter_factura_bloc.dart';

sealed class FilterFacturaState extends Equatable {
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  final bool isPanelOpen;
  const FilterFacturaState({this.clientes = const [], this.empresas = const [], this.isPanelOpen = true});

  @override
  List<Object> get props => [];
}

final class FiltersFacturaInitial extends FilterFacturaState {}

class FiltersFacturaInitialState extends FilterFacturaState {
  const FiltersFacturaInitialState({super.clientes, super.empresas});

  @override
  List<Object> get props => [];
}

class FiltersFacturaLoadingState extends FilterFacturaState {
  const FiltersFacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FiltersFacturaSuccesState extends FilterFacturaState {
  const FiltersFacturaSuccesState();

  @override
  List<Object> get props => [];
}

class FiltersFacturaPanelOpenState extends FilterFacturaState {
  const FiltersFacturaPanelOpenState({super.isPanelOpen});

  @override
  List<Object> get props => [];
}

class FiltersFacturaErrorState extends FilterFacturaState {
  final DioException error;

  const FiltersFacturaErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
