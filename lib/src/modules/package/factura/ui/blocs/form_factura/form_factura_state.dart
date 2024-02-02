part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final bool expanded;
  final bool isValid;
  final bool remesasEnabled;
  final bool remesasfechasEnabled;
  final String empresa;
  const FormFacturaState({
    this.expanded = true,
    this.isValid = false,
    this.empresa = "",
    this.remesasEnabled = false,
    this.remesasfechasEnabled = false,
  });
}

class FormFacturaInitialState extends FormFacturaState {
  const FormFacturaInitialState();

  @override
  List<Object> get props => [];
}

class FormFacturaLoadingState extends FormFacturaState {
  const FormFacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FormFacturaRequestState extends FormFacturaState {
  const FormFacturaRequestState({super.empresa, super.expanded, super.isValid, super.remesasEnabled, super.remesasfechasEnabled});
  @override
  List<Object> get props => [empresa, expanded, isValid, remesasEnabled, remesasfechasEnabled];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState();

  @override
  List<Object> get props => [];
}
