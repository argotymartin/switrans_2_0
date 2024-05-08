part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final Auth? auth;
  final DioException? error;
  final bool isSignedIn;
  const AuthState({this.auth, this.error, this.isSignedIn = false});
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
  @override
  List<Object> get props => <Object>[];
}

class AuthLoadInProgressState extends AuthState {
  const AuthLoadInProgressState();
  @override
  List<Object> get props => <Object>[];
}

class AuthUpdateState extends AuthState {
  const AuthUpdateState();
  @override
  List<Object> get props => <Object>[];
}

class AuthSuccesState extends AuthState {
  const AuthSuccesState({super.auth, super.isSignedIn});

  @override
  List<Object?> get props => <Object?>[super.auth];
}

class AuthErrorState extends AuthState {
  const AuthErrorState({super.error});

  @override
  List<Object?> get props => <Object?>[error];
}
