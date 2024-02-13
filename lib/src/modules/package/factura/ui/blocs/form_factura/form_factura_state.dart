part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final bool expanded;
  final String empresa;
  final String error;
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  const FormFacturaState({
    this.expanded = true,
    this.empresa = "",
    this.error = "",
    this.clientes = const [],
    this.empresas = const [],
  });
}

class FormFacturaInitialState extends FormFacturaState {
  const FormFacturaInitialState();

  @override
  List<Object> get props => [];
}

class FormFacturaDataState extends FormFacturaState {
  const FormFacturaDataState({super.clientes, super.empresas});

  @override
  List<Object> get props => [];
}

class FormFacturaLoadingState extends FormFacturaState {
  const FormFacturaLoadingState();

  @override
  List<Object> get props => [empresa, expanded, error, clientes, empresas];
}

class FormFacturaRequestState extends FormFacturaState {
  const FormFacturaRequestState({super.empresa, super.expanded, super.error, super.clientes, super.empresas});
  @override
  List<Object> get props => [empresa, expanded, error, clientes, empresas];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState();

  @override
  List<Object> get props => [];
}
