part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, succes, error, consulted, exception }

class AuthState extends Equatable {
  final AuthStatus? status;
  final Auth? auth;
  final DioException? error;
  const AuthState({this.status, this.auth, this.error});

  AuthState initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    Auth? auth,
    DioException? error,
  }) =>
      AuthState(
        status: status ?? this.status,
        auth: auth ?? this.auth,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => <Object?>[status, auth, error];
}
