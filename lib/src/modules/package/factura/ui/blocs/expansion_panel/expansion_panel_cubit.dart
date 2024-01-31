import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'expansion_panel_state.dart';

class ExpansionPanelCubit extends Cubit<bool> {
  ExpansionPanelCubit() : super(true);
  final ScrollController controller = ScrollController();

  void setStatePanel(bool state) async {
    moveScroll();
    await Future.delayed(const Duration(milliseconds: 400));
    emit(state);
  }

  void moveScroll() {
    controller.animateTo(
      100,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
    );
  }
}
