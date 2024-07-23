import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

part 'form_factura_event.dart';
part 'form_factura_state.dart';

class FormFacturaBloc extends Bloc<FormFacturaEvent, FormFacturaState> {
  int _clienteCodigo = 1717;
  int _centroCostoCodigo = 0;
  final AbstractFacturaRepository _repository;

  //late AnimationController animationController;
  final ScrollController scrollController = ScrollController();
  final TextEditingController remesasController = TextEditingController();
  final TextEditingController fechacontroller = TextEditingController();

  FormFacturaBloc(this._repository) : super(const FormFacturaInitialState()) {
    on<GetFormFacturaEvent>(_onGetDataFactura);
    on<EmpresaFormFacturaEvent>(_onEventChanged);
    on<TipoFacturaFormFacturaEvent>(_onEventChanged);
    on<DocumentosFormFacturaEvent>(_onSuccesDocumentos);
    on<ErrorFormFacturaEvent>(_onEventChanged);
    on<SuccesFormFacturaEvent>(_onSuccesChanged);

    // scrollController.addListener(() {
    //   debugPrint(scrollController.offset.toString());
    // });
  }

  Future<void> _onGetDataFactura(GetFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    emit(const FormFacturaLoadingState());
    final DataState<List<Cliente>> dataStateClientes = await _repository.getClientes();
    final DataState<List<Empresa>> dataStateEmpresas = await _repository.getEmpresasService();
    final DataState<List<TipoDocumento>> dataStateTipoDocumentos = await _repository.getTipoDocumento();
    if (dataStateClientes.error != null) {
      emit(FormFacturaErrorState(exception: dataStateClientes.error));
    } else if (dataStateEmpresas.error != null) {
      emit(FormFacturaErrorState(exception: dataStateEmpresas.error!));
    } else {
      emit(
        FormFacturaDataState(
          clientes: dataStateClientes.data!,
          empresas: dataStateEmpresas.data!,
          tiposDocumentos: dataStateTipoDocumentos.data!,
        ),
      );
    }
  }

  void _onEventChanged(FormFacturaEvent event, Emitter<FormFacturaState> emit) {
    final List<Cliente> clientes = state.clientes;
    final List<Empresa> empresas = state.empresas;
    final List<TipoDocumento> tiposDocumentos = state.tiposDocumentos;
    int empresa = state.empresa;
    if (event is EmpresaFormFacturaEvent) {
      empresa = event.empresa;
    }

    emit(const FormFacturaLoadingState());
    emit(
      FormFacturaRequestState(
        empresa: empresa,
        clientes: clientes,
        empresas: empresas,
        tiposDocumentos: tiposDocumentos,
      ),
    );
  }

  Future<void> _onSuccesDocumentos(DocumentosFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    final List<Empresa> empresas = state.empresas;
    final List<Cliente> clientes = state.clientes;
    final List<TipoDocumento> tiposDocumentos = state.tiposDocumentos;
    print(tiposDocumentos);
    emit(const FormFacturaLoadingState());
    final DataState<List<Documento>> resp = await _repository.getDocumentosService(event.request);
    if (resp.data != null) {
      final List<Documento> documentos = resp.data!;

      emit(FormDocumentosSuccesState(documentos: documentos, clientes: clientes, empresas: empresas, tiposDocumentos: tiposDocumentos));
    } else {
      emit(FormFacturaErrorState(exception: resp.error!));
      emit(FormFacturaDataState(clientes: clientes, empresas: empresas, tiposDocumentos: tiposDocumentos));
    }
  }

  void _onSuccesChanged(SuccesFormFacturaEvent event, Emitter<FormFacturaState> emit) {
    final List<Cliente> clientes = state.clientes;
    final List<Empresa> empresas = state.empresas;
    final int tipoFactura = state.tipoFactura;
    final int empresa = state.empresa; // return <Documento>[];

    emit(const FormFacturaLoadingState());
    emit(
      FormFacturaSuccesState(
        empresa: empresa,
        clientes: clientes,
        empresas: empresas,
        tipoFactura: tipoFactura,
      ),
    );
  }

  // Future<void> moveScroll(double offset) =>
  //     scrollController.animateTo(offset, duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);

  // Future<void> moveBottomAllScroll() async {
  //   animationController.reset();
  //   await scrollController.animateTo(
  //     scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 1000),
  //     curve: Curves.easeIn,
  //   );
  // }

  Future<void> onPressedSearch({required bool isValid}) async {
    final List<String> fechas = fechacontroller.text.split(" - ");
    String inicio = "";
    String fin = "";
    final int empresa = state.empresa;
    final int tipoFactura = state.tipoFactura;
    final List<String> parts = remesasController.text.split(',').map((String e) => e.trim()).toList();
    final String remesas = parts.join(', ');
    if (fechas.length > 1) {
      inicio = fechas[0].trim();
      fin = fechas[1].trim();
    }

    String error = "";
    if (empresa <= 0) {
      error += " El campo Empresa no puede ser vacio";
    }
    if (clienteCodigo <= 0) {
      error += " El campo Cliente no puede ser vacio";
    }
    if (tipoFactura == 12) {
      if (remesas.isEmpty && inicio.isEmpty) {
        error +=
            " Si se selecciona el tipo (Factura 12), se deben incluir remesas en el filtro, o bien, selecciónar un intervalo de fechas";
      }
      if (inicio != "" && fin == "") {
        error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";
      }
    }

    add(ErrorFormFacturaEvent(error));

    if (isValid && error.isEmpty) {
      final FormFacturaRequest request = FormFacturaRequest(
        empresa: empresa,
        cliente: clienteCodigo,
        remesas: remesas,
        inicio: inicio,
        fin: fin,
      );
      //final List<Documento> resp = await _documentoBloc.getDocumentos(request);
      add(DocumentosFormFacturaEvent(request));

      // if (resp.isNotEmpty) {
      //   add(const SuccesFormFacturaEvent());

      //   //await moveScroll(450);
      // }
      // if (tipoFactura == 10) {
      //   add(const SuccesFormFacturaEvent());
      //   //await moveScroll(450);
      // }
    }
  }

  Cliente getClienteSelected() {
    final Cliente cliente = state.clientes.firstWhere((Cliente element) => element.codigo == clienteCodigo);
    return cliente;
  }

  Empresa getEmpresaSelected() {
    final Empresa empresaSelect = state.empresas.firstWhere((Empresa element) => element.codigo == state.empresa);
    return empresaSelect;
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

  int get clienteCodigo => _clienteCodigo;
  set clienteCodigo(int value) => _clienteCodigo = value;

  int get centroCosto => _centroCostoCodigo;
  set centroCosto(int value) => _centroCostoCodigo = value;
}
