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

class PanelFormFacturaEvent extends FormFacturaEvent {
  final bool isActive;
  const PanelFormFacturaEvent(this.isActive);
}

class ErrorFormFacturaEvent extends FormFacturaEvent {
  final String error;
  const ErrorFormFacturaEvent(this.error);
}
