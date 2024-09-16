part of 'menu_bloc.dart';

enum MenuStatus { initial, loading, succes, error, consulted, exception }

class MenuState extends Equatable {
  final MenuStatus? status;
  final bool? isOpenMenu;
  final bool? isMinimize;
  final bool? isBlocked;
  final List<PaqueteMenu>? paquetes;
  final DioException? error;
  final PaginaMenu? paginaMenu;
  final PaqueteMenu? paqueteMenu;
  final ModuloMenu? moduloMenu;

  const MenuState({
    this.paginaMenu,
    this.status,
    this.isOpenMenu,
    this.isMinimize,
    this.isBlocked,
    this.paquetes,
    this.error,
    this.moduloMenu,
    this.paqueteMenu,
  });
  MenuState initial() => const MenuState(
        status: MenuStatus.initial,
        isOpenMenu: true,
        isMinimize: false,
        isBlocked: false,
        paquetes: <PaqueteMenu>[],
      );
  MenuState copyWith({
    MenuStatus? status,
    bool? isOpenMenu,
    bool? isMinimize,
    bool? isBlocked,
    List<PaqueteMenu>? paquetes,
    DioException? error,
    PaginaMenu? paginaMenu,
    PaqueteMenu? paqueteMenu,
    ModuloMenu? moduloMenu,
  }) =>
      MenuState(
        status: status ?? this.status,
        isOpenMenu: isOpenMenu ?? this.isOpenMenu,
        isMinimize: isMinimize ?? this.isMinimize,
        isBlocked: isBlocked ?? this.isBlocked,
        paquetes: paquetes ?? this.paquetes,
        error: error ?? this.error,
        paginaMenu: paginaMenu ?? this.paginaMenu,
        moduloMenu: moduloMenu ?? this.moduloMenu,
        paqueteMenu: paqueteMenu ?? this.paqueteMenu,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        isOpenMenu,
        isMinimize,
        isBlocked,
        paquetes,
        error,
        paginaMenu,
        paqueteMenu,
        moduloMenu,
      ];
}
