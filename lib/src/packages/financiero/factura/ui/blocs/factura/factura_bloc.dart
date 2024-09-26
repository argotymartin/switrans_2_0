import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'factura_event.dart';
part 'factura_state.dart';

class FacturaBloc extends Bloc<FacturaEvent, FacturaState> {
  final AbstractFacturaRepository _repository;

  FormFacturaRequest _request = FormFacturaRequest(
    empresa: 1,
    documentoCodigo: 11,
    cliente: 2214,
    documentos: "738354,738389,738400,738442,738370,738387,738388,738443",
  );

  FacturaBloc(this._repository) : super(const FacturaState().initial()) {
    on<GetInitialFormFacturaEvent>(_onGetDataFactura);
    on<GetDocumentosFacturaEvent>(_onSuccesDocumentos);
    on<ErrorFacturaEvent>(_onErrorFormFacturaEvent);
    on<SuccesFacturaEvent>(_onSuccesChanged);
    on<AddDocumentoFacturaEvent>(_onAddDocumentoFormFacturaEvent);
    on<RemoveDocumentoFacturaEvent>(_onRemoveDocumentoFormFacturaEvent);
  }

  Future<void> _onGetDataFactura(GetInitialFormFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.loading));
    final DataState<List<Cliente>> dataStateClientes = await _repository.getClientes();
    final DataState<List<Empresa>> dataStateEmpresas = await _repository.getEmpresasService();
    final DataState<List<TipoDocumento>> dataStateTipoDocumentos = await _repository.getTipoDocumento();
    if (dataStateClientes.error != null) {
      emit(state.copyWith(status: FacturaStatus.exception, exception: dataStateClientes.error));
    } else if (dataStateEmpresas.error != null) {
      emit(state.copyWith(status: FacturaStatus.exception, exception: dataStateEmpresas.error));
    } else {
      final List<EntryAutocomplete> entriestiposDocumentos =
          dataStateTipoDocumentos.data!.map((TipoDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();

      final List<EntryAutocomplete> entriesClientes =
          dataStateClientes.data!.map((Cliente e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(
        state.copyWith(
          status: FacturaStatus.initial,
          entriesClientes: entriesClientes,
          empresas: dataStateEmpresas.data!,
          entriesTiposDocumentos: entriestiposDocumentos,
        ),
      );
    }
  }

  Future<void> _onSuccesDocumentos(GetDocumentosFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.loading));
    final DataState<List<Documento>> resp = await _repository.getDocumentosService(event.request);
    if (resp.data != null) {
      final List<Documento> documentos = resp.data!;
      emit(state.copyWith(status: FacturaStatus.succes, documentos: documentos, documentosSelected: <Documento>[]));
    } else {
      emit(state.copyWith(status: FacturaStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onErrorFormFacturaEvent(ErrorFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.error, error: event.error));
  }

  Future<void> _onSuccesChanged(SuccesFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.loading));
  }

  Future<void> _onAddDocumentoFormFacturaEvent(AddDocumentoFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.loading));
    final List<Documento> documentos = <Documento>[...state.documentosSelected];
    if (!documentos.contains(event.documento)) {
      documentos.add(event.documento);
    }
    emit(state.copyWith(status: FacturaStatus.succes, documentosSelected: documentos));
  }

  Future<void> _onRemoveDocumentoFormFacturaEvent(RemoveDocumentoFacturaEvent event, Emitter<FacturaState> emit) async {
    emit(state.copyWith(status: FacturaStatus.loading));
    final List<Documento> documentos = <Documento>[...state.documentosSelected];
    final List<Documento> newDocumentos = documentos..removeWhere((Documento element) => element.documento == event.documento.documento);
    emit(state.copyWith(status: FacturaStatus.succes, documentosSelected: newDocumentos));
  }

  List<MapEntry<int, String>> getCentosCosto() {
    final Set<int> codigosUnicos = state.documentos.map((Documento doc) => doc.centroCostoCodigo).toSet();

    final Map<int, String> centros = <int, String>{};
    for (final int codigo in codigosUnicos) {
      final Documento documento = state.documentos.firstWhere((Documento doc) => doc.centroCostoCodigo == codigo);
      centros[codigo] = documento.centroCostoNombre;
    }
    if (centros.isEmpty) {
      centros[0] = "No tengo centro de costo";
    }

    return centros.entries.toList();
  }

  FormFacturaRequest get request => _request;
  set request(FormFacturaRequest value) => _request = value;
}
