part of 'cliente_bloc.dart';

sealed class ClienteState extends Equatable {
  final List<Cliente> clientes;
  const ClienteState({this.clientes = const []});

  @override
  List<Object> get props => [];
}

final class ClienteInitial extends ClienteState {}

class ClienteInitialState extends ClienteState {
  const ClienteInitialState();

  @override
  List<Object> get props => [];
}

class ClienteLoadingState extends ClienteState {
  const ClienteLoadingState();

  @override
  List<Object> get props => [];
}

class ClienteSuccesState extends ClienteState {
  const ClienteSuccesState({super.clientes});

  @override
  List<Object> get props => [];
}

class ClienteErrorState extends ClienteState {
  final Exception error;

  const ClienteErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
