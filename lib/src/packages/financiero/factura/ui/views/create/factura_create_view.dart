import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/create/widgets/text_area_documento.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatefulWidget {
  const FacturaCreateView({super.key});

  @override
  State<FacturaCreateView> createState() => _FacturaCreateViewState();
}

class _FacturaCreateViewState extends State<FacturaCreateView> {
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
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    const Duration duration = Duration(milliseconds: 1000);
    return BlocListener<DocumentoBloc, DocumentoState>(
      listener: (context, state) {
        if (state is DocumentoErrorState) {
          ErrorDialog.showDioException(context, state.error);
        }
      },
      child: Stack(
        children: [
          ListView(
            controller: context.read<FormFacturaBloc>().scrollController,
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: [
              BuildViewDetail(path: fullPath),
              const SizedBox(height: 16),
              const CustomExpansionPanel(title: "Filtros", child: _BuildFiltros()),
              const SizedBox(height: 16),
              AnimatedScale(
                duration: duration,
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
          ),
          //const Positioned(left: 0, right: 0, bottom: 0, child: ModalItemDocumento()),
        ],
      ),
    );
  }
}

class _BuildFiltros extends StatelessWidget {
  const _BuildFiltros();

  @override
  Widget build(BuildContext context) {
    final formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    final itemDocumentoBloc = BlocProvider.of<ItemDocumentoBloc>(context);
    final List<Empresa> empresas = formFacturaBloc.state.empresas;

    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: _FieldCliente(formFacturaBloc: formFacturaBloc)),
                    const SizedBox(width: 24),
                    const _FieldTipoFactura(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(child: _FieldEmpresa(empresas: empresas)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _FieldRemesas(formFacturaBloc: formFacturaBloc)),
              const SizedBox(width: 24),
              Expanded(child: _FieldFechas(formFacturaBloc: formFacturaBloc)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  itemDocumentoBloc.add(const ResetDocumentoEvent());
                  formFacturaBloc.onPressedSearch(isValid: isValid);
                },
                icon: const Icon(Icons.search_rounded),
                label: const Text("Buscar", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              BlocBuilder<DocumentoBloc, DocumentoState>(
                builder: (context, state) {
                  if (state is DocumentoLoadingState) {
                    return const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 3.0),
                    );
                  }
                  if (state is DocumentoSuccesState) {
                    final remesas = context.read<FormFacturaBloc>().remesasController.text;
                    final List<String> items = remesas.split(",");
                    return Column(
                      children: [
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
          ),
          const SizedBox(height: 8),
          BlocBuilder<FormFacturaBloc, FormFacturaState>(
            builder: (context, state) {
              return (state.error != "") ? ErrorModal(title: state.error) : const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _FieldCliente extends StatelessWidget {
  const _FieldCliente({
    required this.formFacturaBloc,
  });

  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    final facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    final List<Cliente> clientes = facturaFilterBloc.state.clientes;
    final Cliente? cliente = clientes.firstWhereOrNull((element) => element.codigo == formFacturaBloc.clienteCodigo);
    final TextEditingController controller = TextEditingController();
    if (cliente != null) {
      controller.text = cliente.nombre;
    }

    void setValueCliente(EntryAutocomplete entry) {
      formFacturaBloc.clienteCodigo = entry.codigo;
      controller.text = entry.title;
    }

    final List<EntryAutocomplete> entries = clientes.map((cliente) {
      return EntryAutocomplete(
        title: cliente.nombre,
        subTitle: cliente.identificacion,
        codigo: cliente.codigo,
        details: Row(
          children: [
            const Icon(Icons.call, size: 16),
            Text(cliente.telefono, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w100)),
          ],
        ),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

class _FieldTipoFactura extends StatelessWidget {
  const _FieldTipoFactura();

  @override
  Widget build(BuildContext context) {
    void onPressed(MenuEntry entry) {
      context.read<FormFacturaBloc>().add(TipoFacturaFormFacturaEvent(entry.value));
    }

    const List<MenuEntry> entryMenus = [
      MenuEntry(label: "Tipo 10", value: 10),
      MenuEntry(label: "Tipo 12", value: 12),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tipo", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        CustomMenuItemButton(entries: entryMenus, indexSelectedDefault: 0, onPressed: onPressed),
      ],
    );
  }
}

class _FieldEmpresa extends StatelessWidget {
  const _FieldEmpresa({
    required this.empresas,
  });

  final List<Empresa> empresas;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Empresa", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: List.generate(
            empresas.length,
            (index) => SizedBox(
              width: 180,
              child: BuildCardEmpresa(
                empresa: empresas[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FieldRemesas extends StatelessWidget {
  const _FieldRemesas({
    required this.formFacturaBloc,
  });

  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Remesas", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        TextAreaDocumentos(controller: formFacturaBloc.remesasController),
      ],
    );
  }
}

class _FieldFechas extends StatelessWidget {
  const _FieldFechas({
    required this.formFacturaBloc,
  });

  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Inicio", style: AppTheme.titleStyle),
            const SizedBox(height: 8),
            SizedBox(
              width: size.width * 0.15,
              height: 56,
              child: DatetimeInput(controller: formFacturaBloc.fechaInicioController),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Fin", style: AppTheme.titleStyle),
              const SizedBox(height: 8),
              SizedBox(
                width: size.width * 0.15,
                height: 56,
                child: DatetimeInput(controller: formFacturaBloc.fechaFinController),
              ),
            ],
          ),
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
      builder: (context, state) {
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
      builder: (context, state) {
        if (state is FormFacturaSuccesState) {
          return const CustomColorCard(
            icon: Icons.file_copy_outlined,
            title: "Item Documentos",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
        children: [
          const TableItemsDocumento(),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
      builder: (context, state) {
        if (state is DocumentoSuccesState) {
          final documentosAdicion = state.documentos.where((remesa) => remesa.adiciones.isNotEmpty).toList();
          final documentosDescuentos = state.documentos.where((remesa) => remesa.descuentos.isNotEmpty).toList();

          if (documentosAdicion.isNotEmpty || documentosDescuentos.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
    final formFacturaBloc = context.read<FormFacturaBloc>();
    final Cliente clienteSelect = formFacturaBloc.getClienteSelected();
    final Empresa empresaSelect = formFacturaBloc.getEmpresaSelected();
    final TextEditingController controllerCentroCosto = TextEditingController();

    final centrosCosto = context.read<DocumentoBloc>().getCentosCosto();
    final entriesCentroCosto = centrosCosto.map((centro) {
      return EntryAutocomplete(
        codigo: centro.key,
        title: centro.value,
        subTitle: '(${centro.key})',
      );
    }).toList();

    final entrySelected2 = entriesCentroCosto.firstWhereOrNull((entry) => entry.codigo == formFacturaBloc.centroCosto);
    final String entrySelected = entrySelected2 != null ? entrySelected2.title : "";

    void setValueFactura(EntryAutocomplete value) {
      if (value.codigo > 0) {
        context.read<ItemDocumentoBloc>().add(const GetItemDocumentoEvent());
        formFacturaBloc.centroCosto = value.codigo;
      }
    }

    return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
      builder: (context, state) {
        if (state is ItemDocumentoSuccesState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.work_outline_outlined),
                        const SizedBox(width: 8),
                        Text(empresaSelect.nombre),
                      ],
                    ),
                    Row(
                      children: [
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
                  entrySelected: entrySelected,
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
      builder: (context, state) {
        final DocumentoBloc facturaBloc = context.read<DocumentoBloc>();
        final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
        final documentos = facturaBloc.state.documentos;
        final itemDocumentos = state.itemDocumentos.where((element) => element.documento > 0);
        final double totalDocumentos = documentos.fold(0, (total, documento) => total + documento.rcp);
        final double totalImpuestos = itemDocumentos.fold(0, (total, item) => total + item.valorIva);
        final double totalPrefacturas = itemDocumentos.fold(0, (total, prefactura) => total + prefactura.total);
        final double valorFaltante = totalDocumentos - totalPrefacturas;

        final bool isTransporte = state.itemDocumentos.any((element) => element.tipo == "TR");
        final bool isDocumento = !state.itemDocumentos.any((element) => element.documento <= 0);
        final bool isCantidad = !state.itemDocumentos.any((element) => element.cantidad <= 0);
        final bool isValor = !state.itemDocumentos.any((element) => element.valor <= 0);
        final bool isDescripcion = state.itemDocumentos.any((element) => element.descripcion.isNotEmpty);
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
                    final prefacturaRequest = PrefacturaRequest(
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
