part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final int empresa;
  final int tipoFactura;
  final String error;
  final List<Cliente> clientes;
  final List<Empresa> empresas;
  final List<TipoDocumento> tiposDocumentos;
  final DioException? exception;
  final List<Documento> documentos;

  const FormFacturaState({
    this.empresa = 1,
    this.tipoFactura = 10,
    this.error = "",
    this.clientes = const <Cliente>[],
    this.empresas = const <Empresa>[],
    this.tiposDocumentos = const <TipoDocumento>[],
    this.documentos = const <Documento>[],
    this.exception,
  });
}

class FormFacturaInitialState extends FormFacturaState {
  const FormFacturaInitialState();

  @override
  List<Object> get props => <Object>[];
}

class FormFacturaDataState extends FormFacturaState {
  const FormFacturaDataState({super.clientes, super.empresas, super.tiposDocumentos});

  @override
  List<Object> get props => <Object>[clientes, empresas, tiposDocumentos];
}

class FormFacturaLoadingState extends FormFacturaState {
  const FormFacturaLoadingState();

  @override
  List<Object> get props => <Object>[];
}

class FormFacturaRequestState extends FormFacturaState {
  const FormFacturaRequestState({super.empresa, super.clientes, super.empresas, super.tiposDocumentos});
  @override
  List<Object> get props => <Object>[empresa, clientes, empresas, tiposDocumentos];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState({super.empresa, super.clientes, super.empresas, super.tipoFactura});

  @override
  List<Object> get props => <Object>[empresa, clientes, empresas, tipoFactura];
}

class FormDocumentosSuccesState extends FormFacturaState {
  const FormDocumentosSuccesState({super.documentos, super.empresa, super.clientes, super.empresas, super.tiposDocumentos});

  @override
  List<Object> get props => <Object>[empresa, error, clientes, empresas, tipoFactura];
}

class FormFacturaErrorState extends FormFacturaState {
  const FormFacturaErrorState({super.exception, super.documentos, super.empresa, super.clientes, super.empresas, super.tiposDocumentos});

  @override
  List<DioException?> get props => <DioException?>[exception];
}
