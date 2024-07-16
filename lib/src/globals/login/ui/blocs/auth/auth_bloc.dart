import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/login/domain/repositories/abstract_auth_repository.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthInitialState()) {
    on<GetAuthEvent>((GetAuthEvent event, Emitter<AuthState> emit) {});
    on<LoginAuthEvent>(_onActivateUser);

    on<LogoutAuthEvent>(((LogoutAuthEvent event, Emitter<AuthState> emit) => emit(const AuthInitialState())));
    on<ValidateAuthEvent>(((ValidateAuthEvent event, Emitter<AuthState> emit) => emit(AuthSuccesState(auth: event.auth))));
  }

  Future<void> _onActivateUser(LoginAuthEvent event, Emitter<AuthState> emit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', "");
    emit(const AuthLoadInProgressState());
    final DataState<Auth> dataState = await _repository.signin(event.params);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(AuthSuccesState(auth: dataState.data!, isSignedIn: true));
      await prefs.setString('token', dataState.data!.token);
    }
    if (dataState.error != null) {
      emit(AuthErrorState(error: dataState.error));
    }
  }

  Future<void> onLogoutAuthEvent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', "");
    add(const LogoutAuthEvent());
  }

  Future<bool> onValidateToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String token = prefs.getString('token') ?? '';

    bool isValid = false;
    final UsuarioRequest params = UsuarioRequest(token: token);
    final DataState<Auth> dataState = await _repository.validateToken(params);
    if (dataState is DataSuccess && dataState.data != null) {
      add(ValidateAuthEvent(dataState.data!));
      await prefs.setString('token', dataState.data!.token);
      isValid = true;
    } else {
      isValid = false;
    }

    return isValid;
  }
}
