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
    on<AuthEvent>((event, emit) {});
    on<GetAuthEvent>((event, emit) {
      emit(const AuthLoadInProgressState());
      emit(const AuthSuccesState());
    });
    on<LoginAuthEvent>(_onActivateUser);
    on<LogoutAuthEvent>(((event, emit) => emit(const AuthInitialState())));
  }

  Future<void> _onActivateUser(LoginAuthEvent event, Emitter<AuthState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "");
    emit(const AuthLoadInProgressState());
    final dataState = await _repository.signin(event.params);
    if (dataState is DataSuccess && dataState.data != null) {
      emit(AuthSuccesState(auth: dataState.data!, isSignedIn: true));
      prefs.setString('token', dataState.data!.token);
    }
    if (dataState.error != null) {
      emit(AuthErrorState(error: dataState.error));
    }
  }

  Future<bool> onValidateToken(String token) async {
    bool isValid = false;

    final params = UsuarioRequest(token: token);
    isValid = await _repository.validateToken(params);
    return isValid;
  }
}
