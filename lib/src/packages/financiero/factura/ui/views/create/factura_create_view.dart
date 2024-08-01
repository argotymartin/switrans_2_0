import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_cliente.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_documentos.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_empresa.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_fechas.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_tipo_documento.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_flex_form_fields.dart';
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
        if (state is FormFacturaLoadingState) {
          return const LoadingView();
        }
        return const FacturaCreateFields();
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
          FormButton(
            label: "Buscar",
            icon: Icons.search,
            onPressed: () {
              final bool isValid = formKey.currentState!.validate();
              itemDocumentoBloc.add(const ResetDocumentoEvent());
              formFacturaBloc.onPressedSearch(isValid: isValid);
            },
          ),
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
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        if (state is FormDocumentosSuccesState) {
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
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        if (state is FormFacturaRequestState) {
          final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
          final Cliente clienteSelect = formFacturaBloc.getClienteSelected();
          final Empresa empresaSelect = formFacturaBloc.getEmpresaSelected();
          final TextEditingController controllerCentroCosto = TextEditingController();

          final List<MapEntry<int, String>> centrosCosto = context.read<FormFacturaBloc>().getCentosCosto();
          final List<EntryAutocomplete> entriesCentroCosto = centrosCosto.map((MapEntry<int, String> centro) {
            return EntryAutocomplete(
              codigo: centro.key,
              title: centro.value,
              subTitle: '(${centro.key})',
            );
          }).toList();

          void setValueFactura(EntryAutocomplete value) {
            if (value.codigo != null) {
              context.read<ItemDocumentoBloc>().add(const GetItemDocumentoEvent());
              formFacturaBloc.centroCosto = value.codigo!;
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
        } else {
          return const SizedBox();
        }
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
        final FormFacturaBloc facturaBloc = context.read<FormFacturaBloc>();
        final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<ItemDocumento> itemDocumentos = state.itemDocumentos.where((ItemDocumento element) => element.documento > 0);
        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.rcp);
        final double totalImpuestos = itemDocumentos.fold(0, (double total, ItemDocumento item) => total + item.valorIva);

        return FormButton(
          label: "Registrar",
          icon: Icons.add_card_rounded,
          onPressed: () {
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
          },
        );
      },
    );
  }
}
