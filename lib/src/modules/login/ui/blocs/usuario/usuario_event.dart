part of 'usuario_bloc.dart';

abstract class UsuarioEvent extends Equatable {
  const UsuarioEvent();

  @override
  List<Object> get props => [];
}

class GetUsuarioEvent extends UsuarioEvent {
  const GetUsuarioEvent();
}

class LoginUsuarioEvent extends UsuarioEvent {
  final UsuarioRequest params;
  const LoginUsuarioEvent({required this.params});
}

class LogoutUsuarioEvent extends UsuarioEvent {
  const LogoutUsuarioEvent();
}
