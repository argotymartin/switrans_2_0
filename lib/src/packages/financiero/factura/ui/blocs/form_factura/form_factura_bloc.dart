import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';

part 'form_factura_event.dart';
part 'form_factura_state.dart';

class FormFacturaBloc extends Bloc<FormFacturaEvent, FormFacturaState> {
  final AbstractFacturaRepository _repository;

  FormFacturaRequest _request = FormFacturaRequest(empresa: 1, documentoCodigo: 11, cliente: 1228, documentos: "738544,738548,738551");

  FormFacturaBloc(this._repository) : super(const FormFacturaState().initial()) {
    on<GetFormFacturaEvent>(_onGetDataFactura);
    on<DocumentosFormFacturaEvent>(_onSuccesDocumentos);
    on<ErrorFormFacturaEvent>(_onErrorFormFacturaEvent);
    on<SuccesFormFacturaEvent>(_onSuccesChanged);
    on<AddDocumentoFormFacturaEvent>(_onAddDocumentoFormFacturaEvent);
    on<RemoveDocumentoFormFacturaEvent>(_onRemoveDocumentoFormFacturaEvent);
  }

  Future<void> _onGetDataFactura(GetFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.loading));
    final DataState<List<Cliente>> dataStateClientes = await _repository.getClientes();
    final DataState<List<Empresa>> dataStateEmpresas = await _repository.getEmpresasService();
    final DataState<List<TipoDocumento>> dataStateTipoDocumentos = await _repository.getTipoDocumento();
    if (dataStateClientes.error != null) {
      emit(state.copyWith(status: FormFacturaStatus.exception, exception: dataStateClientes.error));
    } else if (dataStateEmpresas.error != null) {
      emit(state.copyWith(status: FormFacturaStatus.exception, exception: dataStateEmpresas.error));
    } else {
      final List<EntryAutocomplete> entriestiposDocumentos =
          dataStateTipoDocumentos.data!.map((TipoDocumento e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();

      final List<EntryAutocomplete> entriesClientes =
          dataStateClientes.data!.map((Cliente e) => EntryAutocomplete(title: e.nombre, codigo: e.codigo)).toList();
      emit(
        state.copyWith(
          status: FormFacturaStatus.initial,
          entriesClientes: entriesClientes,
          empresas: dataStateEmpresas.data!,
          entriesTiposDocumentos: entriestiposDocumentos,
        ),
      );
    }
  }

  Future<void> _onSuccesDocumentos(DocumentosFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.loading));
    final DataState<List<Documento>> resp = await _repository.getDocumentosService(event.request);
    if (resp.data != null) {
      final List<Documento> documentos = resp.data!;
      emit(state.copyWith(status: FormFacturaStatus.succes, documentos: documentos, documentosSelected: <Documento>[]));
    } else {
      emit(state.copyWith(status: FormFacturaStatus.exception, exception: resp.error));
    }
  }

  Future<void> _onErrorFormFacturaEvent(ErrorFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.error, error: event.error));
  }

  Future<void> _onSuccesChanged(SuccesFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.loading));
  }

  Future<void> _onAddDocumentoFormFacturaEvent(AddDocumentoFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.loading));
    final List<Documento> documentos = <Documento>[...state.documentosSelected];
    documentos.add(event.documento);
    emit(state.copyWith(status: FormFacturaStatus.succes, documentosSelected: documentos));
  }

  Future<void> _onRemoveDocumentoFormFacturaEvent(RemoveDocumentoFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(state.copyWith(status: FormFacturaStatus.loading));
    final List<Documento> documentos = <Documento>[...state.documentosSelected];
    final List<Documento> newDocumentos = documentos..removeWhere((Documento element) => element.documento == event.documento.documento);
    emit(state.copyWith(status: FormFacturaStatus.succes, documentosSelected: newDocumentos));
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
