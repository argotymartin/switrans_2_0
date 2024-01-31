part of 'formulario_factura_cubit.dart';

abstract class FormularioFacturaState extends Equatable {
  final bool expanded;
  const FormularioFacturaState({this.expanded = false});

  @override
  List<Object> get props => [];
}

class FormularioFacturaInitial extends FormularioFacturaState {}
