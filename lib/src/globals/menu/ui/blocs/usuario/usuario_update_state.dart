part of 'usuario_update_bloc.dart';

enum UsuarioStatus { initial, loading, success, error, consulted, exception }

class UsuarioUpdateState extends Equatable {
  final UsuarioStatus? status;
  final PlatformFile? file;
  final Usuario ? usuario;
  final int? codigo;
  final DioException? exception;
  const UsuarioUpdateState({
    this.status,
    this.file,
    this.usuario,
    this.codigo,
    this.exception,
  });

  UsuarioUpdateState initial() => const UsuarioUpdateState(status: UsuarioStatus.initial);

  UsuarioUpdateState copyWith({
    UsuarioStatus? status,
    PlatformFile? file,
    Usuario? usuario,
    int? codigo,
    DioException? exception,
  }) =>
      UsuarioUpdateState(
        status: status ?? this.status,
        file: file ?? this.file,
        usuario: usuario ?? this.usuario,
        codigo: codigo ?? this.codigo,
        exception: exception ?? this.exception,
      );

  @override
  List<Object?> get props => <Object?>[status, file, codigo, exception];
}
