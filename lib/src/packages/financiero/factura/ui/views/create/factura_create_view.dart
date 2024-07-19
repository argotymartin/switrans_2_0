import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/button_search_factura_form.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_cliente.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_documentos.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_empresa.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_fechas.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_flex_form_fields.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormFacturaBloc, FormFacturaState>(
      listener: (BuildContext context, FormFacturaState state) {
        if (state is FormFacturaErrorState) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, FormFacturaState state) {
        if (state is FormFacturaDataState) {
          return const FacturaCreateFields();
        }
        if (state is FormFacturaRequestState) {
          return const FacturaCreateFields();
        }
        if (state is FormFacturaSuccesState) {
          return const FacturaCreateFields();
        }
        return const LoadingView();
      },
    );
  }
}

class FacturaCreateFields extends StatefulWidget {
  const FacturaCreateFields({super.key});

  @override
  State<FacturaCreateFields> createState() => _FacturaCreateFieldsState();
}

class _FacturaCreateFieldsState extends State<FacturaCreateFields> {
  late ScrollController _controller;
  double pixels = 0.0;
  @override
  void initState() {
    _controller = context.read<FormFacturaBloc>().scrollController;
    _controller.addListener(() {
      if (mounted) {
        setState(() => pixels = _controller.offset);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: context.read<FormFacturaBloc>().scrollController,
      padding: const EdgeInsets.only(right: 32, top: 8),
      physics: const ClampingScrollPhysics(),
      children: const <Widget>[
        BuildViewDetail(),
        SizedBox(height: 16),
        CustomExpansionPanel(
          title: "Filtros",
          iconOn: Icons.filter_alt_rounded,
          iconOff: Icons.filter_alt_off_outlined,
          child: _BuildFiltros(),
        ),
        SizedBox(height: 16),
        CustomExpansionPanel(
          title: "Documentos",
          iconOn: Icons.folder,
          iconOff: Icons.folder_off_outlined,
          child: _BuildDocumentos(),
        ),
        SizedBox(height: 16),
        CustomExpansionPanel(
          title: "Item Documentos",
          iconOn: Icons.content_paste_outlined,
          iconOff: Icons.content_paste_off,
          child: _BuildItemFactura(),
        ),
        // AnimatedScale(
        //   duration: duration,
        //   curve: Curves.easeInOut,
        //   scale: pixels >= 100 ? 1.0 : 0.5,
        //   child: AnimatedOpacity(
        //     opacity: pixels >= 100 ? 1.0 : 0.0,
        //     duration: duration,
        //     child: const _BuildDocumentos(),
        //   ),
        // ),
        // const SizedBox(height: 16),
        // AnimatedScale(
        //   duration: duration,
        //   scale: pixels >= 100 ? 1.0 : 0.5,
        //   child: AnimatedOpacity(
        //     opacity: pixels >= 100 ? 1.0 : 0.0,
        //     duration: duration,
        //     child: const _BuildItemFactura(),
        //   ),
        // ),
        // const SizedBox(height: 32),
      ],
    );
  }
}

class _BuildFiltros extends StatelessWidget {
  const _BuildFiltros();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    final ItemDocumentoBloc itemDocumentoBloc = BlocProvider.of<ItemDocumentoBloc>(context);

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFlexFormFields(
            children: <FlexWidgetForm>[
              FlexWidgetForm(flex: 1, widget: const FieldFacturaTipoDocumento()),
              FlexWidgetForm(flex: 2, widget: const FieldFacturaCliente()),
              FlexWidgetForm(flex: 3, widget: const FieldFacturaEmpresa()),
              FlexWidgetForm(flex: 3, widget: const FieldFacturaDocumentos()),
              FlexWidgetForm(flex: 3, widget: const FieldFacturaFechas()),
            ],
          ),
          const SizedBox(height: 24),
          ButtonSearchFacturaForm(formKey: formKey, itemDocumentoBloc: itemDocumentoBloc, formFacturaBloc: formFacturaBloc),
          const SizedBox(height: 8),
          BlocBuilder<FormFacturaBloc, FormFacturaState>(
            builder: (BuildContext context, FormFacturaState state) {
              return (state.error != "") ? ErrorModal(title: state.error) : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _BuildDocumentos extends StatelessWidget {
  const _BuildDocumentos();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentoBloc, DocumentoState>(
      builder: (BuildContext context, DocumentoState state) {
        if (state is DocumentoSuccesState) {
          if (state.documentos.isNotEmpty) {
            return TableDocumentos(documentos: state.documentos);
          }
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildItemFactura extends StatelessWidget {
  const _BuildItemFactura();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BuildTableItemsDocumento(),
        Divider(height: 48, color: Colors.white),
        _BuildPrefacturarDocumento(),
        SizedBox(height: 24),
      ],
    );
  }
}

class _BuildTableItemsDocumento extends StatelessWidget {
  const _BuildTableItemsDocumento();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimary,
      child: const Column(
        children: <Widget>[
          const TableItemsDocumento(),
          const SizedBox(height: 24),
          CardDetailsFactura(),
        ],
      ),
    );
  }
}

class _BuildPrefacturarDocumento extends StatelessWidget {
  const _BuildPrefacturarDocumento();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
    final Cliente clienteSelect = formFacturaBloc.getClienteSelected();
    final Empresa empresaSelect = formFacturaBloc.getEmpresaSelected();
    final TextEditingController controllerCentroCosto = TextEditingController();

    final List<MapEntry<int, String>> centrosCosto = context.read<DocumentoBloc>().getCentosCosto();
    final List<EntryAutocomplete> entriesCentroCosto = centrosCosto.map((MapEntry<int, String> centro) {
      return EntryAutocomplete(
        codigo: centro.key,
        title: centro.value,
        subTitle: '(${centro.key})',
      );
    }).toList();

    void setValueFactura(EntryAutocomplete value) {
      if (value.codigo > 0) {
        context.read<ItemDocumentoBloc>().add(const GetItemDocumentoEvent());
        formFacturaBloc.centroCosto = value.codigo;
      }
    }

    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        if (state is ItemDocumentoSuccesState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(Icons.work_outline_outlined),
                        const SizedBox(width: 8),
                        Text(empresaSelect.nombre),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.contact_emergency_outlined),
                        const SizedBox(width: 8),
                        Text(clienteSelect.nombre),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 400,
                child: AutocompleteInput(
                  entries: entriesCentroCosto,
                  label: "Centro Costo",
                  controller: controllerCentroCosto,
                  onPressed: setValueFactura,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 160,
                child: CustomOutlinedButton(
                  icon: Icons.delete_forever_outlined,
                  colorText: Colors.white,
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.error,
                  text: "Cancelar",
                ),
              ),
              const SizedBox(width: 16),
              const _BuildButtonRegistrar(),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildButtonRegistrar extends StatelessWidget {
  const _BuildButtonRegistrar();

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();

    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (BuildContext context, ItemDocumentoState state) {
        final DocumentoBloc facturaBloc = context.read<DocumentoBloc>();
        final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<ItemDocumento> itemDocumentos = state.itemDocumentos.where((ItemDocumento element) => element.documento > 0);
        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.rcp);
        final double totalImpuestos = itemDocumentos.fold(0, (double total, ItemDocumento item) => total + item.valorIva);
        final double totalPrefacturas = itemDocumentos.fold(0, (double total, ItemDocumento prefactura) => total + prefactura.total);
        final double valorFaltante = totalDocumentos - totalPrefacturas;

        final bool isTransporte = state.itemDocumentos.any((ItemDocumento element) => element.tipo == "TR");
        final bool isDocumento = !state.itemDocumentos.any((ItemDocumento element) => element.documento <= 0);
        final bool isCantidad = !state.itemDocumentos.any((ItemDocumento element) => element.cantidad <= 0);
        final bool isValor = !state.itemDocumentos.any((ItemDocumento element) => element.valor <= 0);
        final bool isDescripcion = state.itemDocumentos.any((ItemDocumento element) => element.descripcion.isNotEmpty);
        final bool isCentroCosto = formFacturaBloc.centroCosto > 0;
        final bool isFaltante = valorFaltante.toInt() == 0;

        /*debugPrint("isTransporte: $isTransporte");
        debugPrint("isDocumento: $isDocumento");
        debugPrint("isCantidad: $isCantidad");
        debugPrint("isValor: $isValor");
        debugPrint("isDescripcion: $isDescripcion");
        debugPrint("isCentroCosto: $isCentroCosto");
        debugPrint("isCentroCosto: ${formFacturaBloc.centroCosto}");
        debugPrint("isFaltante: $isFaltante");
        debugPrint("valorFaltante: ${valorFaltante.toInt()}");
        debugPrint("***********************");*/

        return SizedBox(
          width: 240,
          child: FilledButton.icon(
            onPressed: isDocumento && isTransporte && isCentroCosto && isCantidad && isValor && isDescripcion && isFaltante
                ? () {
                    final int centroCosto = formFacturaBloc.centroCosto;
                    final int clienteCodigo = formFacturaBloc.clienteCodigo;
                    final int empresaCodigo = formFacturaBloc.state.empresa;
                    final int usuario = authBloc.state.auth!.usuario.codigo;
                    final PrefacturaRequest prefacturaRequest = PrefacturaRequest(
                      centroCosto: centroCosto,
                      cliente: clienteCodigo,
                      empresa: empresaCodigo,
                      usuario: usuario,
                      valorImpuesto: totalImpuestos.toInt(),
                      valorNeto: totalDocumentos.toInt(),
                      documentos: documentos,
                      items: itemDocumentos.toList(),
                    );

                    debugPrint("${prefacturaRequest.toJson()}");
                  }
                : null,
            icon: const Icon(Icons.add_card_rounded),
            label: const Text("Registrar Pre-Factura"),
          ),
        );
      },
    );
  }
}
