part of 'form_factura_bloc.dart';

abstract class FormFacturaState extends Equatable {
  final bool expanded;
  final String empresa;
  final String error;
  const FormFacturaState({
    this.expanded = true,
    this.empresa = "",
    this.error = "",
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
  const FormFacturaRequestState({
    super.empresa,
    super.expanded,
    super.error,
  });
  @override
  List<Object> get props => [empresa, expanded, error];
}

class FormFacturaSuccesState extends FormFacturaState {
  const FormFacturaSuccesState();

  @override
  List<Object> get props => [];
}
