import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';

part 'factura_event.dart';
part 'factura_state.dart';

class FacturaBloc extends Bloc<FacturaEvent, FacturaState> {
  final AbstractFacturaRepository _repository;
  FacturaBloc(this._repository) : super(FacturaInitial()) {
    on<FacturaEvent>((event, emit) {});
    on<ChangedFacturaEvent>((event, emit) async {
      emit(const FacturaLoadingState());
      emit(FacturaSuccesState(documentos: event.documentos));
    });

    on<GetDocumentosFacturaEvent>((event, emit) async {
      emit(const FacturaLoadingState());
      final resp = await _repository.getDocumentosService(event.request);
      emit(FacturaSuccesState(documentos: resp.data!));
    });
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
