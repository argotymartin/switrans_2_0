import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/tipo_documento.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/text_area_documento.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/forms/build_flex_form_fields.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/web_date_picker2.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormFacturaBloc, FormFacturaState>(
      listener: (BuildContext context, FormFacturaState state) {
        if (state is FormFacturaErrorState) {
          CustomToast.showError(context, state.exception!.response!.data!);
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
    const Duration duration = Duration(milliseconds: 1000);
    return ListView(
      controller: context.read<FormFacturaBloc>().scrollController,
      padding: const EdgeInsets.only(right: 32, top: 8),
      physics: const ClampingScrollPhysics(),
      children: <Widget>[
        const BuildViewDetail(),
        const SizedBox(height: 16),
        const CustomExpansionPanel(title: "Filtros", child: _BuildFiltros()),
        const SizedBox(height: 16),
        AnimatedScale(
          duration: duration,
          curve: Curves.easeInOut,
          scale: pixels >= 100 ? 1.0 : 0.5,
          child: AnimatedOpacity(
            opacity: pixels >= 100 ? 1.0 : 0.0,
            duration: duration,
            child: const _BuildDocumentos(),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedScale(
          duration: duration,
          scale: pixels >= 100 ? 1.0 : 0.5,
          child: AnimatedOpacity(
            opacity: pixels >= 100 ? 1.0 : 0.0,
            duration: duration,
            child: const _BuildItemFactura(),
          ),
        ),
        const SizedBox(height: 32),
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
              FlexWidgetForm(flex: 1, widget: const _FieldTipoDocumento()),
              FlexWidgetForm(flex: 2, widget: const _FieldCliente()),
              FlexWidgetForm(flex: 3, widget: const _FieldEmpresa()),
              FlexWidgetForm(flex: 3, widget: const _FieldDocumentos()),
              FlexWidgetForm(flex: 3, widget: const _FieldFechas()),
            ],
          ),
          const SizedBox(height: 24),
          BuildButtonForm(formKey: formKey, itemDocumentoBloc: itemDocumentoBloc, formFacturaBloc: formFacturaBloc),
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

class _FieldTipoDocumento extends StatelessWidget {
  const _FieldTipoDocumento();

  @override
  Widget build(BuildContext context) {
    final List<TipoDocumento> tiposDocumentos = context.read<FormFacturaBloc>().state.tiposDocumentos;
    final TextEditingController controller = TextEditingController();
    void onPressed(EntryAutocomplete entry) {
      //context.read<FormFacturaBloc>().add(TipoFacturaFormFacturaEvent(entry.codigo));
    }

    final List<EntryAutocomplete> entries = tiposDocumentos.map((TipoDocumento tipoDocumento) {
      return EntryAutocomplete(
        title: tipoDocumento.nombre,
        codigo: tipoDocumento.codigo,
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Tipo Documento", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          controller: controller,
          label: "Tipo",
          entryCodigoSelected: 1,
          entries: entries,
          onPressed: onPressed,
          minChractersSearch: 0,
        ),
      ],
    );
  }
}

class _FieldCliente extends StatelessWidget {
  const _FieldCliente();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    final List<Cliente> clientes = facturaFilterBloc.state.clientes;
    final Cliente? cliente = clientes.firstWhereOrNull((Cliente element) => element.codigo == facturaFilterBloc.clienteCodigo);
    final TextEditingController controller = TextEditingController();
    if (cliente != null) {
      controller.text = cliente.nombre;
    }

    void setValueCliente(EntryAutocomplete entry) {
      facturaFilterBloc.clienteCodigo = entry.codigo;
      controller.text = entry.title;
    }

    final List<EntryAutocomplete> entries = clientes.map((Cliente cliente) {
      return EntryAutocomplete(
        title: cliente.nombre,
        subTitle: cliente.identificacion,
        codigo: cliente.codigo,
        details: Row(
          children: <Widget>[
            const Icon(Icons.call, size: 16),
            Text(cliente.telefono, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w100)),
          ],
        ),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Cliente", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          label: "Cliente",
          entries: entries,
          onPressed: setValueCliente,
          controller: controller,
          minChractersSearch: 3,
        ),
      ],
    );
  }
}

class _FieldEmpresa extends StatelessWidget {
  const _FieldEmpresa();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    final List<Empresa> empresas = formFacturaBloc.state.empresas;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Empresa", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        Wrap(
          runSpacing: 8,
          spacing: 16,
          clipBehavior: Clip.antiAlias,
          children: List<Widget>.generate(
            empresas.length,
            (int index) => SizedBox(width: 180, child: BuildCardEmpresa(empresa: empresas[index])),
          ),
        ),
      ],
    );
  }
}

class _FieldDocumentos extends StatelessWidget {
  const _FieldDocumentos();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Documentos", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        TextAreaDocumentos(controller: formFacturaBloc.remesasController),
      ],
    );
  }
}

class _FieldFechas extends StatelessWidget {
  const _FieldFechas();

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(" Fecha Inicio - Fecha Fin", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        WebDatePicker2(controller: formFacturaBloc.fechacontroller),
      ],
    );
  }
}

class BuildButtonForm extends StatelessWidget {
  const BuildButtonForm({
    required this.formKey,
    required this.itemDocumentoBloc,
    required this.formFacturaBloc,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ItemDocumentoBloc itemDocumentoBloc;
  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FilledButton.icon(
          onPressed: () {
            final bool isValid = formKey.currentState!.validate();
            itemDocumentoBloc.add(const ResetDocumentoEvent());
            formFacturaBloc.onPressedSearch(isValid: isValid);
          },
          icon: const Icon(Icons.search_rounded),
          label: const Text("Buscar", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        BlocBuilder<DocumentoBloc, DocumentoState>(
          builder: (BuildContext context, DocumentoState state) {
            if (state is DocumentoLoadingState) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3.0),
              );
            }
            if (state is DocumentoSuccesState) {
              final String remesas = context.read<FormFacturaBloc>().remesasController.text;
              final List<String> items = remesas.split(",");
              return Column(
                children: <Widget>[
                  Text(
                    remesas.isEmpty ? "Encontrados" : "Consultadas/Encontrados",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    remesas.isEmpty ? "${state.documentos.length}" : "${items.length}/${state.documentos.length}",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
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
            return WhiteCard(
              icon: Icons.insert_drive_file_outlined,
              title: "Factura Documentos",
              child: TableDocumentos(documentos: state.documentos),
            );
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
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        if (state is FormFacturaSuccesState) {
          return const CustomColorCard(
            icon: Icons.file_copy_outlined,
            title: "Item Documentos",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _BuildDetailsDocumentos(),
                _BuildTableItemsDocumento(),
                Divider(height: 48, color: Colors.white),
                _BuildPrefacturarDocumento(),
                SizedBox(height: 24),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildTableItemsDocumento extends StatelessWidget {
  const _BuildTableItemsDocumento();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        children: <Widget>[
          const TableItemsDocumento(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => context.read<ItemDocumentoBloc>().add(const AddItemServicioAdicionalFacturaEvent()),
                icon: const Icon(Icons.add_card_rounded),
                label: const Text("Adicionar"),
              ),
              const CardDetailsFactura(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildDetailsDocumentos extends StatelessWidget {
  const _BuildDetailsDocumentos();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentoBloc, DocumentoState>(
      builder: (BuildContext context, DocumentoState state) {
        if (state is DocumentoSuccesState) {
          final List<Documento> documentosAdicion = state.documentos.where((Documento remesa) => remesa.adiciones.isNotEmpty).toList();
          final List<Documento> documentosDescuentos = state.documentos.where((Documento remesa) => remesa.descuentos.isNotEmpty).toList();

          if (documentosAdicion.isNotEmpty || documentosDescuentos.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  documentosAdicion.isNotEmpty
                      ? Expanded(child: CardAdicionesAndDescuentos(documentos: documentosAdicion, title: 'ADICIONES', color: Colors.green))
                      : const Expanded(child: SizedBox()),
                  const SizedBox(width: 48),
                  documentosDescuentos.isNotEmpty
                      ? Expanded(
                          child: CardAdicionesAndDescuentos(documentos: documentosDescuentos, title: 'DESCUENTOS', color: Colors.red),
                        )
                      : const Expanded(child: SizedBox()),
                ],
              ),
            );
          }
        }
        return const SizedBox();
      },
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
                  entryCodigoSelected: formFacturaBloc.centroCosto,
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
