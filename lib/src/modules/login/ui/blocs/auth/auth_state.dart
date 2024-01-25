part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final Usuario? usuario;
  final DioException? error;
  final bool isSignedIn;
  const AuthState({this.usuario, this.error, this.isSignedIn = false});
}

class AuthStateState extends AuthState {
  const AuthStateState();
  @override
  List<Object> get props => [];
}

class UsuarioLoadInProgressState extends AuthState {
  const UsuarioLoadInProgressState();
  @override
  List<Object> get props => [];
}

class UsuarioUpdateState extends AuthState {
  const UsuarioUpdateState();
  @override
  List<Object> get props => [];
}

class UsuarioSuccesState extends AuthState {
  const UsuarioSuccesState({super.usuario, super.isSignedIn});

  @override
  List<Object?> get props => [super.usuario];
}

class UsuarioErrorState extends AuthState {
  const UsuarioErrorState({super.error});

  @override
  List<Object?> get props => [error];
}
