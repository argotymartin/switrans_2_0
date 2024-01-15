part of 'usuario_bloc.dart';

abstract class UsuarioState extends Equatable {
  final Usuario? usuario;
  final DioException? error;
  const UsuarioState({this.usuario, this.error});
}

class UsuarioInitialState extends UsuarioState {
  const UsuarioInitialState();
  @override
  List<Object> get props => [];
}

class UsuarioLoadInProgressState extends UsuarioState {
  const UsuarioLoadInProgressState();
  @override
  List<Object> get props => [];
}

class UsuarioUpdateState extends UsuarioState {
  const UsuarioUpdateState();
  @override
  List<Object> get props => [];
}

class UsuarioSuccesState extends UsuarioState {
  const UsuarioSuccesState({super.usuario});

  @override
  List<Object?> get props => [super.usuario];
}

class UsuarioErrorState extends UsuarioState {
  const UsuarioErrorState({super.error});

  @override
  List<Object?> get props => [error];
}
