import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'form_factura_event.dart';
part 'form_factura_state.dart';

class FormFacturaBloc extends Bloc<FormFacturaEvent, FormFacturaState> {
  int _clienteCodigo = 0;
  int _centroCostoCodigo = 0;
  int _tipoFactura = 0;
  final AbstractFacturaRepository _repository;
  final DocumentoBloc _documentoBloc;

  late AnimationController animationController;
  final ScrollController scrollController = ScrollController();
  final TextEditingController remesasController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();

  FormFacturaBloc(this._repository, this._documentoBloc) : super(const FormFacturaInitialState()) {
    on<GetFormFacturaEvent>(_onGetDataFactura);
    on<EmpresaFormFacturaEvent>(_onEventChanged);
    on<TipoFacturaFormFacturaEvent>(_onEventChanged);
    on<ErrorFormFacturaEvent>(_onEventChanged);
    on<SuccesFormFacturaEvent>(_onSuccesChanged);

    scrollController.addListener(() {
      //debugPrint(scrollController.offset.toString());
    });

    scrollController.addListener(() {
      // if (scrollController.offset >= 800) animationController.reset();
    });
  }

  void _onGetDataFactura(GetFormFacturaEvent event, Emitter<FormFacturaState> emit) async {
    final int empresa = state.empresa;
    String error = state.error;
    emit(const FormFacturaLoadingState());
    final dataStateClientes = await _repository.getClientes();
    final dataStateEmpresas = await _repository.getEmpresasService();
    emit(FormFacturaDataState(
      clientes: dataStateClientes.data!,
      empresas: dataStateEmpresas.data!,
      empresa: empresa,
      error: error,
    ));
  }

  void _onEventChanged(FormFacturaEvent event, Emitter<FormFacturaState> emit) {
    List<Cliente> clientes = state.clientes;
    List<Empresa> empresas = state.empresas;
    String error = state.error;
    int tipoFactura = state.tipoFactura;
    int empresa = state.empresa;
    if (event is EmpresaFormFacturaEvent) empresa = event.empresa;
    if (event is TipoFacturaFormFacturaEvent) tipoFactura = event.tipoFactura;
    if (event is ErrorFormFacturaEvent) error = event.error;

    emit(const FormFacturaLoadingState());
    emit(FormFacturaRequestState(
      error: error,
      empresa: empresa,
      clientes: clientes,
      empresas: empresas,
      tipoFactura: tipoFactura,
    ));
  }

  void _onSuccesChanged(SuccesFormFacturaEvent event, Emitter<FormFacturaState> emit) {
    List<Cliente> clientes = state.clientes;
    List<Empresa> empresas = state.empresas;
    String error = state.error;
    int tipoFactura = state.tipoFactura;
    int empresa = state.empresa;

    emit(const FormFacturaLoadingState());
    emit(FormFacturaSuccesState(
      error: error,
      empresa: empresa,
      clientes: clientes,
      empresas: empresas,
      tipoFactura: tipoFactura,
    ));
  }

  Future moveScroll(double offset) =>
      scrollController.animateTo(offset, duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);

  void moveBottomAllScroll() {
    //animationController.reset();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeIn,
    );
  }

  void onPressedSearch(bool isValid) async {
    //fechaInicioController.text = "2023-01-01";
    //fechaFinController.text = "2024-01-01";

    final empresa = state.empresa;
    final tipoFactura = state.tipoFactura;
    final remesas = remesasController.text;
    final inicio = fechaInicioController.text;
    final fin = fechaFinController.text;

    String error = "";
    if (empresa <= 0) error += " El campo Empresa no puede ser vacio";
    if (clienteCodigo <= 0) error += " El campo Cliente no puede ser vacio";
    if (tipoFactura == 12) {
      if (remesas.isEmpty && inicio.isEmpty) {
        error +=
            " Si se selecciona el tipo (Factura 12), se deben incluir remesas en el filtro, o bien, selecciónar un intervalo de fechas";
      }
      if (inicio != "" && fin == "") error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";
    }

    add(ErrorFormFacturaEvent(error));

    if (isValid && error.isEmpty) {
      final FacturaRequest request = FacturaRequest(
        empresa: empresa,
        cliente: clienteCodigo,
        remesas: remesas,
        inicio: inicio,
        fin: fin,
      );
      final List<Documento> resp = await _documentoBloc.getDocumentos(request);

      if (resp.isNotEmpty) {
        add(const SuccesFormFacturaEvent());
        moveScroll(450);
      }
      if (tipoFactura == 10) {
        add(const SuccesFormFacturaEvent());
        moveScroll(450);
      }
    }
  }

  Cliente getClienteSelected() {
    final Cliente cliente = state.clientes.firstWhere((element) => element.codigo == clienteCodigo);
    return cliente;
  }

  Empresa getEmpresaSelected() {
    final Empresa empresaSelect = state.empresas.firstWhere((element) => element.codigo == state.empresa);
    return empresaSelect;
  }

  int get clienteCodigo => _clienteCodigo;
  set setClienteCodigo(int value) => _clienteCodigo = value;

  int get centroCosto => _centroCostoCodigo;
  set setCentroCosto(int value) => _centroCostoCodigo = value;

  int get tipoFactura => _tipoFactura;
  set setTipoFactura(int value) => _tipoFactura = value;
}
