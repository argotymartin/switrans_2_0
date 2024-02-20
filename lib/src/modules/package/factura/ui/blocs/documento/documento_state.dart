part of 'documento_bloc.dart';

sealed class DocumentoState extends Equatable {
  final List<Documento> documentos;
  const DocumentoState({this.documentos = const []});

  @override
  List<Object> get props => [];
}

final class DocumentoInitial extends DocumentoState {}

class DocumentoInitialState extends DocumentoState {
  const DocumentoInitialState();

  @override
  List<Object> get props => [];
}

class DocumentoLoadingState extends DocumentoState {
  const DocumentoLoadingState();

  @override
  List<Object> get props => [];
}

class DocumentoSuccesState extends DocumentoState {
  const DocumentoSuccesState({super.documentos});

  @override
  List<Object> get props => [];
}

class DocumentoErrorState extends DocumentoState {
  final Exception error;

  const DocumentoErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
