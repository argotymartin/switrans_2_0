import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'formulario_factura_state.dart';

class FormularioFacturaCubit extends Cubit<FormularioFacturaState> {
  FormularioFacturaCubit() : super(const FormularioFacturaInitial());
  final ScrollController controller = ScrollController();
  late AnimationController animationController;

  void remesafilter(String empresa) {
    emit(const FormularioFacturaLoading());
    emit(FormularioFacturaRequestState(empresa: empresa, expanded: state.expanded));
  }

  void setStatePanel(bool isExpanded) async {
    moveScroll();
    await Future.delayed(const Duration(milliseconds: 200));
    emit(FormularioFacturaRequestState(expanded: isExpanded, empresa: state.empresa));
  }

  void onFormIsValid() async {
    emit(const FormularioFacturaRequestState(isValid: true));
  }

  void moveScroll() {
    controller.animateTo(
      100,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
    );
  }

  void moveBottomAllScroll() {
    animationController.reset();
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
    );
  }
}
