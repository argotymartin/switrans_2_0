import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';

part 'documento_event.dart';
part 'documento_state.dart';

class DocumentoBloc extends Bloc<DocumentoEvent, DocumentoState> {
  final AbstractFacturaRepository _repository;

  DocumentoBloc(this._repository) : super(DocumentoInitial()) {
    on<DocumentoEvent>((event, emit) {});
    on<ChangedDocumentoEvent>((event, emit) async {
      emit(const DocumentoLoadingState());
      emit(DocumentoSuccesState(documentos: event.documentos));
    });

    on<GetDocumentoEvent>((event, emit) => emit(const DocumentoLoadingState()));
    on<ErrorDocumentoEvent>((event, emit) => emit(DocumentoErrorState(error: event.exception)));
  }

  Future<List<Documento>> getDocumentos(FacturaRequest request) async {
    add(const GetDocumentoEvent());
    final resp = await _repository.getDocumentosService(request);
    if (resp.data != null) {
      List<Documento> documentos = resp.data!;
      add(ChangedDocumentoEvent(documentos));
      return resp.data!;
    } else {
      add(ErrorDocumentoEvent(resp.error!));
    }
    return [];
  }

  List<MapEntry<int, String>> getCentosCosto() {
    final codigosUnicos = state.documentos.map((doc) => doc.cencosCodigo).toSet();

    final centros = <int, String>{};
    for (int codigo in codigosUnicos) {
      final documento = state.documentos.firstWhere((doc) => doc.cencosCodigo == codigo);
      centros[codigo] = documento.cencosNombre;
    }
    if (centros.isEmpty) {
      centros[0] = "No tengo centro de costo";
    }

    return centros.entries.toList();
  }
}
