part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final int empresa;
  final int tipoFactura;
  final String error;
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  const FormFacturaState({
    this.empresa = 1,
    this.tipoFactura = 10,
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
  const FormFacturaDataState({super.clientes, super.empresas, super.empresa, super.error, super.tipoFactura});

  @override
  List<Object> get props => [clientes, empresas];
}

class FormFacturaLoadingState extends FormFacturaState {
  const FormFacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FormFacturaRequestState extends FormFacturaState {
  const FormFacturaRequestState({super.empresa, super.error, super.clientes, super.empresas, super.tipoFactura});
  @override
  List<Object> get props => [empresa, error, clientes, empresas, tipoFactura];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState();

  @override
  List<Object> get props => [];
}
