part of 'cliente_bloc.dart';

sealed class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

class GetClienteEvent extends ClienteEvent {
  const GetClienteEvent();
}

class ActiveteClienteEvent extends ClienteEvent {
  final String cliente;
  const ActiveteClienteEvent(this.cliente);
}
