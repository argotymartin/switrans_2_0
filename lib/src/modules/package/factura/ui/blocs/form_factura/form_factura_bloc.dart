import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/repositories/abstract_factura_repository.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

part 'form_factura_event.dart';
part 'form_factura_state.dart';

class FormFacturaBloc extends Bloc<FormFacturaEvent, FormFacturaState> {
  final AbstractFacturaRepository _repository;
  final FacturaBloc _facturaBloc;

  late AnimationController animationController;
  final ScrollController scrollController = ScrollController();
  final TextEditingController clienteController = TextEditingController();
  final TextEditingController remesasController = TextEditingController();
  final TextEditingController fechaInicioController = TextEditingController();
  final TextEditingController fechaFinController = TextEditingController();

  FormFacturaBloc(this._repository, this._facturaBloc) : super(const FormFacturaInitialState()) {
    on<GetFormFacturaEvent>((event, emit) async {
      final dataStateClientes = await _repository.getClientes();
      final dataStateEmpresas = await _repository.getEmpresasService();
      emit(FormFacturaDataState(clientes: dataStateClientes.data!, empresas: dataStateEmpresas.data!));
    });

    on<EmpresaFormFacturaEvent>((event, emit) {
      List<Cliente> clientes = state.clientes;
      List<Empresa> empresas = state.empresas;
      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(
        empresa: event.empresa,
        error: state.error,
        clientes: clientes,
        empresas: empresas,
      ));
    });

    //scrollController.addListener(() => print(scrollController.offset));

    on<ErrorFormFacturaEvent>((event, emit) async {
      final String empresa = state.empresa;
      emit(const FormFacturaLoadingState());
      emit(FormFacturaRequestState(error: event.error, empresa: empresa, expanded: state.expanded));
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
    //final empresa = state.empresa;
    const empresa = "1";
    //final cliente = formFacturaBloc.clienteController.text;
    const cliente = "1409";
    remesasController.text = "736801,736978,443534";
    final remesas = remesasController.text;
    //const remesas = "01035-3378,01035-3379,01035-3380,01039-3069";
    //const remesas = "736801,736801,736917,736918,736978,443534,434196,434196,473845,467345";
    //const remesas = "736801,736978,443534";
    final inicio = fechaInicioController.text;
    final fin = fechaFinController.text;
    String error = "";
    if (empresa.isEmpty) error += " El campo Empresa no puede ser vacio";
    if (cliente.isEmpty) error += " El campo Cliente no puede ser vacio";
    if (remesas.isEmpty && inicio.isEmpty) error += " Se deben agregar remesas al filtro o un intervalo de fechas";
    if (inicio != "" && fin == "") error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";

    if (error.isNotEmpty) {
      add(ErrorFormFacturaEvent(error));
    }
    if (isValid && error.isEmpty) {
      final FacturaRequest request = FacturaRequest(
        empresa: int.parse(empresa),
        cliente: int.parse(cliente),
        remesas: remesas,
        inicio: inicio,
        fin: fin,
      );
      _facturaBloc.add(GetDocumentosFacturaEvent(request));
      await moveScroll(500);
    }
  }
}
