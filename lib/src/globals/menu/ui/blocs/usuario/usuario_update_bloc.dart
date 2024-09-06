import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/globals/menu/domain/repositories/abstract_usuario_update_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'usuario_update_event.dart';
part 'usuario_update_state.dart';

class UsuarioUpdateBloc extends Bloc<UsuarioUpdateEvent, UsuarioUpdateState> {
  final AbstractUsuarioUpdateRepository _repository;
  final UsuarioRequest _request = UsuarioRequest();

  UsuarioUpdateBloc(this._repository) : super(const UsuarioUpdateState().initial()) {
    on<UsuarioInitialEvent>(_onInitial);
    on<UpdateUsuarioEvent>(_onUpdate);
    on<ErrorFormUsuarioEvent>(_onErrorForm);
  }

  Future<void> _onInitial(UsuarioInitialEvent event, Emitter<UsuarioUpdateState> emit) async {
    _request.clean();
    emit(state.copyWith(status: UsuarioStatus.initial));
  }

  Future<void> _onUpdate(UpdateUsuarioEvent event, Emitter<UsuarioUpdateState> emit) async {
    emit(state.copyWith(status: UsuarioStatus.loading));
    final DataState<dynamic> response = await _repository.updateUsuario(event.request);
    if (response.data != null) {
      emit(state.copyWith(status: UsuarioStatus.success, usuario: response.data));
    } else {
      emit(state.copyWith(status: UsuarioStatus.exception, exception: response.error));
    }
  }

  Future<void> _onErrorForm(ErrorFormUsuarioEvent event, Emitter<UsuarioUpdateState> emit) async {
    emit(state.copyWith(status: UsuarioStatus.exception, exception: event.exception));
  }
}
