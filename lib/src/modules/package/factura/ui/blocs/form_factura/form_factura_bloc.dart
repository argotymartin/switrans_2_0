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
  final AbstractFacturaRepository _repository;
  final DocumentoBloc _documentoBloc;

  late AnimationController animationController;
  final ScrollController scrollController = ScrollController();
  final TextEditingController remesasController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();

  FormFacturaBloc(this._repository, this._documentoBloc) : super(const FormFacturaInitialState()) {
    on<GetFormFacturaEvent>((event, emit) async {
      final int empresa = state.empresa;
      String error = state.error;

      emit(const FormFacturaLoadingState());
      final dataStateClientes = await _repository.getClientes();
      final dataStateEmpresas = await _repository.getEmpresasService();
      emit(FormFacturaDataState(
        clientes: dataStateClientes.data!,
        empresas: dataStateEmpresas.data!,
        empresa: empresa <= 0 ? 1 : empresa,
        error: error,
      ));
    });

    on<EmpresaFormFacturaEvent>((event, emit) {
      List<Cliente> clientes = state.clientes;
      List<Empresa> empresas = state.empresas;
      String error = state.error;

      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(
        empresa: event.empresa,
        error: error,
        clientes: clientes,
        empresas: empresas,
      ));
    });

    scrollController.addListener(() {
      debugPrint(scrollController.offset.toString());
    });

    on<ErrorFormFacturaEvent>((event, emit) async {
      List<Cliente> clientes = state.clientes;
      List<Empresa> empresas = state.empresas;
      int empresa = state.empresa;

      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(
        error: event.error,
        empresa: empresa,
        clientes: clientes,
        empresas: empresas,
      ));
    });

    scrollController.addListener(() {
      if (scrollController.offset >= 120) animationController.reset();
    });
  }

  Future moveScroll(double offset) => scrollController.animateTo(offset, duration: kThemeAnimationDuration, curve: Curves.easeIn);

  void moveBottomAllScroll() {
    animationController.reset();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: kThemeAnimationDuration,
      curve: Curves.easeIn,
    );
  }

  void onPressedSearch(bool isValid) async {
    //NotificationSlack().sendMessage("Esta es una prueba desde Flutter");
    //add(const EmpresaFormFacturaEvent("1"));
    //clienteController.text = "1409";
    remesasController.text = "736801,736978,443534,736918";
    setClienteCodigo = 1409;

    final empresa = state.empresa;
    final remesas = remesasController.text;
    //const remesas = "01035-3378,01035-3379,01035-3380,01039-3069";
    //const remesas = "736801,736801,736917,736918,736978,443534,434196,434196,473845,467345";
    //const remesas = "736801,736978,443534";
    final inicio = fechaInicioController.text;
    final fin = fechaFinController.text;
    String error = "";
    if (empresa <= 0) error += " El campo Empresa no puede ser vacio";
    if (clienteCodigo <= 0) error += " El campo Cliente no puede ser vacio";
    if (remesas.isEmpty && inicio.isEmpty) error += " Se deben agregar remesas al filtro o un intervalo de fechas";
    if (inicio != "" && fin == "") error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";

    add(ErrorFormFacturaEvent(error));

    if (isValid && error.isEmpty) {
      final FacturaRequest request = FacturaRequest(
        empresa: empresa,
        cliente: clienteCodigo,
        remesas: remesas,
        inicio: inicio,
        fin: fin,
      );
      _documentoBloc.add(GetDocumentoEvent(request));
      await moveScroll(500);
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
}
