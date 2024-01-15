import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/modules/login/domain/repositories/abstract_usuario_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'usuario_event.dart';
part 'usuario_state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final AbstractUsuarioRepository _repository;

  UsuarioBloc(this._repository) : super(const UsuarioInitialState()) {
    on<UsuarioEvent>((event, emit) {});
    on<LoginUsuarioEvent>(_onActivateUser);
    on<LogoutUsuarioEvent>(((event, emit) => emit(const UsuarioInitialState())));
  }

  Future<void> _onActivateUser(LoginUsuarioEvent event, Emitter<UsuarioState> emit) async {
    emit(const UsuarioLoadInProgressState());
    final dataState = await _repository.getUsuario(event.params);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(UsuarioSuccesState(usuario: dataState.data, isSignedIn: true));
    }
    if (dataState.error != null) {
      emit(UsuarioErrorState(error: dataState.error));
    }
  }
}
