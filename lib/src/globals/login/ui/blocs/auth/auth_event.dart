part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoginAuthEvent extends AuthEvent {
  final UsuarioRequest params;
  const LoginAuthEvent({required this.params});
}

class LogoutAuthEvent extends AuthEvent {
  const LogoutAuthEvent();
}

class ValidateAuthEvent extends AuthEvent {
  final Auth auth;
  const ValidateAuthEvent(this.auth);
}

class RefreshAuthEvent extends AuthEvent {
  const RefreshAuthEvent();
}
