part of 'documento_bloc.dart';

sealed class DocumentoState extends Equatable {
  final List<Documento> documentos;
  const DocumentoState({this.documentos = const <Documento>[]});

  @override
  List<Object> get props => <Object>[];
}

final class DocumentoInitial extends DocumentoState {}

class DocumentoInitialState extends DocumentoState {
  const DocumentoInitialState();

  @override
  List<Object> get props => <Object>[];
}

class DocumentoLoadingState extends DocumentoState {
  const DocumentoLoadingState();

  @override
  List<Object> get props => <Object>[];
}

class DocumentoSuccesState extends DocumentoState {
  const DocumentoSuccesState({super.documentos});

  @override
  List<Object> get props => <Object>[];
}

class DocumentoErrorState extends DocumentoState {
  final DioException error;

  const DocumentoErrorState({required this.error});
  @override
  List<Object> get props => <Object>[error];
}
