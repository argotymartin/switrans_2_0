import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'formulario_factura_state.dart';

class FormularioFacturaCubit extends Cubit<bool> {
  FormularioFacturaCubit() : super(true);
  final ScrollController controller = ScrollController();
  late AnimationController animationController;

  void setStatePanel(bool state) async {
    moveScroll();
    await Future.delayed(const Duration(milliseconds: 200));
    emit(state);
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
