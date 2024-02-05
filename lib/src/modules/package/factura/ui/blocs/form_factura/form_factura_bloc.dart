import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'form_factura_event.dart';
part 'form_factura_state.dart';

class FormFacturaBloc extends Bloc<FormFacturaEvent, FormFacturaState> {
  late AnimationController animationController;
  final ScrollController scrollController = ScrollController();
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController remesasController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();

  FormFacturaBloc() : super(const FormFacturaInitialState()) {
    on<EmpresaFormFacturaEvent>((event, emit) {
      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(empresa: event.empresa, error: state.error));
    });

    on<PanelFormFacturaEvent>((event, emit) async {
      moveScroll();
      await Future.delayed(const Duration(milliseconds: 250));
      emit(FormFacturaRequestState(expanded: event.isActive, empresa: state.empresa, error: state.error));
    });

    on<ErrorFormFacturaEvent>((event, emit) async {
      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(error: event.error, empresa: state.empresa, expanded: state.expanded));
    });

    scrollController.addListener(() {
      if (scrollController.offset >= 120) animationController.reset();
    });
  }

  void moveScroll() => scrollController.animateTo(100, duration: kThemeAnimationDuration, curve: Curves.easeIn);

  void moveBottomAllScroll() {
    animationController.reset();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
    );
  }
}
