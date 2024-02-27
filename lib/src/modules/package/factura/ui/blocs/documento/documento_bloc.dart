import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';

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

    on<GetDocumentoEvent>((event, emit) async {
      emit(const DocumentoLoadingState());
    });
  }

  Future<List<Documento>> getDocumentos(final FacturaRequest request) async {
    add(const GetDocumentoEvent());
    final resp = await _repository.getDocumentosService(request);

    add(ChangedDocumentoEvent(resp.data!));
    return resp.data!;
  }

  List<MapEntry<int, String>> getCentosCosto() {
    final codigosUnicos = state.documentos.map((doc) => doc.cencosCodigo).toSet();

    final centros = <int, String>{};
    for (int codigo in codigosUnicos) {
      final documento = state.documentos.firstWhere((doc) => doc.cencosCodigo == codigo);
      centros[codigo] = documento.cencosNombre;
    }
    return centros.entries.toList();
  }
}
