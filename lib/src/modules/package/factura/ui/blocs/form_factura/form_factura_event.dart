part of 'form_factura_bloc.dart';

abstract class FormFacturaEvent extends Equatable {
  const FormFacturaEvent();

  @override
  List<Object> get props => [];
}

class GetFormFacturaEvent extends FormFacturaEvent {
  const GetFormFacturaEvent();
}

class RemesasFormFacturaEvent extends FormFacturaEvent {
  final bool remesasEnabled;
  const RemesasFormFacturaEvent(this.remesasEnabled);
}

class EmpresaFormFacturaEvent extends FormFacturaEvent {
  final String empresa;
  const EmpresaFormFacturaEvent(this.empresa);
}

class PanelFormFacturaEvent extends FormFacturaEvent {
  final bool isActive;
  const PanelFormFacturaEvent(this.isActive);
}
