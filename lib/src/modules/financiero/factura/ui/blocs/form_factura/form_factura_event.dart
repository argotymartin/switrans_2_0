part of 'form_factura_bloc.dart';

abstract class FormFacturaEvent extends Equatable {
  const FormFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFormFacturaEvent extends FormFacturaEvent {
  const GetFormFacturaEvent();
}

class EmpresaFormFacturaEvent extends FormFacturaEvent {
  final int empresa;
  const EmpresaFormFacturaEvent(this.empresa);
}

class TipoFacturaFormFacturaEvent extends FormFacturaEvent {
  final int tipoFactura;
  const TipoFacturaFormFacturaEvent(this.tipoFactura);
}

class ErrorFormFacturaEvent extends FormFacturaEvent {
  final String error;
  const ErrorFormFacturaEvent(this.error);
}

class SuccesFormFacturaEvent extends FormFacturaEvent {
  const SuccesFormFacturaEvent();
}
