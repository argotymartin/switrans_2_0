part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final Usuario? usuario;
  final DioException? error;
  final bool isSignedIn;
  const AuthState({this.usuario, this.error, this.isSignedIn = false});
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
  @override
  List<Object> get props => [];
}

class AuthLoadInProgressState extends AuthState {
  const AuthLoadInProgressState();
  @override
  List<Object> get props => [];
}

class AuthUpdateState extends AuthState {
  const AuthUpdateState();
  @override
  List<Object> get props => [];
}

class AuthSuccesState extends AuthState {
  const AuthSuccesState({super.usuario, super.isSignedIn});

  @override
  List<Object?> get props => [super.usuario];
}

class AuthErrorState extends AuthState {
  const AuthErrorState({super.error});

  @override
  List<Object?> get props => [error];
}
