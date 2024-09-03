import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthState().initial()) {
    on<LoginAuthEvent>(_onLoginAuthEvent);
    on<LogoutAuthEvent>(_onLogoutAuthEvent);
    on<ValidateAuthEvent>(
      ((ValidateAuthEvent event, Emitter<AuthState> emit) => emit(state.copyWith(status: AuthStatus.succes, auth: event.auth))),
    );
  }

  Future<void> _onLoginAuthEvent(LoginAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final DataState<Auth> dataState = await _repository.signin(event.params);
    if (dataState is DataSuccess && dataState.data != null) {
      Preferences.usuarioNombre = dataState.data!.usuario.nombre;
      emit(state.copyWith(status: AuthStatus.succes, auth: dataState.data!));
      Preferences.token = dataState.data!.token;
    }
    if (dataState.error != null) {
      emit(state.copyWith(status: AuthStatus.error, error: dataState.error));
    }
  }

  Future<void> _onLogoutAuthEvent(LogoutAuthEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    emit(const AuthState().initial());
    Preferences.token = "";
  }

  Future<bool> onValidateToken() async {
    bool isValid = true;
    final UsuarioRequest params = UsuarioRequest(token: Preferences.token);
    final DataState<Auth> dataState = await _repository.validateToken(params);
    if (dataState is DataSuccess && dataState.data != null) {
      Preferences.token = dataState.data!.token;
      isValid = true;
      add(ValidateAuthEvent(dataState.data!));
    } else {
      isValid = false;
    }
    return isValid;
  }
}
