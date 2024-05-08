part of 'servicio_empresarial_bloc.dart';

sealed class ServicioEmpresarialState extends Equatable {
  final List<ServicioEmpresarial> serviciosEmpresariales;
  final ServicioEmpresarial? servicioEmpresarial;
  final String errorForm;

  const ServicioEmpresarialState({
    this.serviciosEmpresariales = const <ServicioEmpresarial>[],
    this.errorForm = '',
    this.servicioEmpresarial,
  });

  @override
  List<Object> get props => <Object>[];
}

class ServicioEmpresarialInitialState extends ServicioEmpresarialState {
  const ServicioEmpresarialInitialState();

  @override
  List<Object> get props => <Object>[];
}

class ServicioEmpresarialLoadingState extends ServicioEmpresarialState {
  const ServicioEmpresarialLoadingState();

  @override
  List<Object> get props => <Object>[];
}

class ServicioEmpresarialSuccesState extends ServicioEmpresarialState {
  const ServicioEmpresarialSuccesState({super.servicioEmpresarial});

  @override
  List<Object> get props => <Object>[servicioEmpresarial!];
}

class ServicioEmpresarialConsultedState extends ServicioEmpresarialState {
  const ServicioEmpresarialConsultedState({super.serviciosEmpresariales});

  @override
  List<Object> get props => <Object>[serviciosEmpresariales];
}

class ServicioEmpresarialErrorFormState extends ServicioEmpresarialState {
  const ServicioEmpresarialErrorFormState({super.errorForm});

  @override
  List<Object> get props => <Object>[errorForm];
}

class ServicioEmpresarialExceptionState extends ServicioEmpresarialState {
  final DioException exception;

  const ServicioEmpresarialExceptionState({required this.exception});
  @override
  List<Object> get props => <Object>[exception];
}
