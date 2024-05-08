import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'documento_event.dart';
part 'documento_state.dart';

class DocumentoBloc extends Bloc<DocumentoEvent, DocumentoState> {
  final AbstractFacturaRepository _repository;

  DocumentoBloc(this._repository) : super(DocumentoInitial()) {
    on<DocumentoEvent>((DocumentoEvent event, Emitter<DocumentoState> emit) {});
    on<ChangedDocumentoEvent>((ChangedDocumentoEvent event, Emitter<DocumentoState> emit) async {
      emit(const DocumentoLoadingState());
      emit(DocumentoSuccesState(documentos: event.documentos));
    });

    on<GetDocumentoEvent>((GetDocumentoEvent event, Emitter<DocumentoState> emit) => emit(const DocumentoLoadingState()));
    on<ErrorDocumentoEvent>((ErrorDocumentoEvent event, Emitter<DocumentoState> emit) => emit(DocumentoErrorState(error: event.exception)));
  }

  Future<List<Documento>> getDocumentos(FacturaRequest request) async {
    add(const GetDocumentoEvent());
    final DataState<List<Documento>> resp = await _repository.getDocumentosService(request);
    if (resp.data != null) {
      final List<Documento> documentos = resp.data!;
      add(ChangedDocumentoEvent(documentos));
      return resp.data!;
    } else {
      add(ErrorDocumentoEvent(resp.error!));
    }
    return <Documento>[];
  }

  List<MapEntry<int, String>> getCentosCosto() {
    final Set<int> codigosUnicos = state.documentos.map((Documento doc) => doc.cencosCodigo).toSet();

    final Map<int, String> centros = <int, String>{};
    for (final int codigo in codigosUnicos) {
      final Documento documento = state.documentos.firstWhere((Documento doc) => doc.cencosCodigo == codigo);
      centros[codigo] = documento.cencosNombre;
    }
    if (centros.isEmpty) {
      centros[0] = "No tengo centro de costo";
    }

    return centros.entries.toList();
  }
}
