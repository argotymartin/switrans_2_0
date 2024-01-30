import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expansion_panel_state.dart';

class ExpansionPanelCubit extends Cubit<bool> {
  ExpansionPanelCubit() : super(true);

  void setStatePanel(bool state) {
    emit(state);
  }
}
