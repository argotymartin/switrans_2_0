part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final int empresa;
  final int tipoFactura;
  final String error;
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  final DioException? exception;
  const FormFacturaState({
    this.empresa = 1,
    this.tipoFactura = 10,
    this.error = "",
    this.clientes = const <Cliente>[],
    this.empresas = const <Empresa>[],
    this.exception,
  });
}

class FormFacturaInitialState extends FormFacturaState {
  const FormFacturaInitialState();

  @override
  List<Object> get props => <Object>[];
}

class FormFacturaDataState extends FormFacturaState {
  const FormFacturaDataState({super.clientes, super.empresas, super.empresa, super.error, super.tipoFactura});

  @override
  List<Object> get props => <Object>[clientes, empresas];
}

class FormFacturaLoadingState extends FormFacturaState {
  const FormFacturaLoadingState();

  @override
  List<Object> get props => <Object>[];
}

class FormFacturaRequestState extends FormFacturaState {
  const FormFacturaRequestState({super.empresa, super.error, super.clientes, super.empresas, super.tipoFactura});
  @override
  List<Object> get props => <Object>[empresa, error, clientes, empresas, tipoFactura];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState({super.empresa, super.error, super.clientes, super.empresas, super.tipoFactura});

  @override
  List<Object> get props => <Object>[empresa, error, clientes, empresas, tipoFactura];
}

class FormFacturaErrorState extends FormFacturaState {
  const FormFacturaErrorState({super.exception});

  @override
  List<DioException?> get props => <DioException?>[exception];
}
