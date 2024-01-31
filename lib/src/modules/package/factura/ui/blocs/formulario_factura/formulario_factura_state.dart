part of 'formulario_factura_cubit.dart';

abstract class FormularioFacturaState extends Equatable {
  final bool expanded;
  final bool isValid;
  final String empresa;

  const FormularioFacturaState({this.expanded = true, this.isValid = false, this.empresa = ""});
}

class FormularioFacturaInitial extends FormularioFacturaState {
  const FormularioFacturaInitial();
  @override
  List<Object> get props => [];
}

class FormularioFacturaLoading extends FormularioFacturaState {
  const FormularioFacturaLoading();
  @override
  List<Object> get props => [];
}

class FormularioFacturaRequestState extends FormularioFacturaState {
  const FormularioFacturaRequestState({super.empresa, super.expanded, super.isValid});
  @override
  List<Object> get props => [empresa, expanded, isValid];
}
