part of 'usuario_update_bloc.dart';

abstract class UsuarioUpdateEvent{
  final PlatformFile? platformFile;
  const UsuarioUpdateEvent({this.platformFile});
}

class UsuarioInitialEvent extends UsuarioUpdateEvent {
  const UsuarioInitialEvent();
}

class UpdateUsuarioEvent extends UsuarioUpdateEvent {
  final UsuarioRequest request;
  const UpdateUsuarioEvent({required this.request});
}

class ErrorFormUsuarioEvent extends UsuarioUpdateEvent {
  final DioException? exception;
  const ErrorFormUsuarioEvent(this.exception);
}
