part of 'documento_bloc.dart';

sealed class DocumentoState extends Equatable {
  final List<Documento> documentos;
  const DocumentoState({this.documentos = const []});

  @override
  List<Object> get props => [];
}

final class FacturaInitial extends DocumentoState {}

class FacturaInitialState extends DocumentoState {
  const FacturaInitialState();

  @override
  List<Object> get props => [];
}

class FacturaLoadingState extends DocumentoState {
  const FacturaLoadingState();

  @override
  List<Object> get props => [];
}

class FacturaSuccesState extends DocumentoState {
  const FacturaSuccesState({super.documentos});

  @override
  List<Object> get props => [];
}

class FacturaErrorState extends DocumentoState {
  final Exception error;

  const FacturaErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
