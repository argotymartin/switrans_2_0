import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/modules/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatefulWidget {
  const FacturaCreateView({
    Key? key,
  }) : super(key: key);

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
    List<String> names = fullPath.split("/");
    return Stack(
      children: [
        ListView(
          controller: context.read<FormFacturaBloc>().scrollController,
          padding: const EdgeInsets.only(right: 32, top: 8),
          physics: const ClampingScrollPhysics(),
          children: [
            BuildViewDetail(
              title: "Factura",
              detail: "Sistema de gestión de facturas que permite la facturación de servicios para diversos clientes con facilidad",
              breadcrumbTrails: names,
            ),
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
        const Positioned(left: 0, right: 0, bottom: 0, child: ModalItemDocumento()),
      ],
    );
  }
}

class _BuildFiltros extends StatelessWidget {
  const _BuildFiltros();

  @override
  Widget build(BuildContext context) {
    final formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    final itemDocumentoBloc = BlocProvider.of<ItemDocumentoBloc>(context);
    List<Empresa> empresas = formFacturaBloc.state.empresas;

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
              )),
              const SizedBox(width: 24),
              Expanded(child: _FieldEmpresa(empresas: empresas))
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _FieldRemesas(formFacturaBloc: formFacturaBloc)),
              const SizedBox(width: 24),
              Expanded(child: _FieldFechas(formFacturaBloc: formFacturaBloc))
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              FilledButton.icon(
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  itemDocumentoBloc.add(const ResetDocumentoEvent());
                  formFacturaBloc.onPressedSearch(isValid);
                },
                icon: const Icon(Icons.search_rounded),
                label: const Text("Buscar", style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 8),
              BlocBuilder<DocumentoBloc, DocumentoState>(
                builder: (context, state) {
                  final remesas = context.read<FormFacturaBloc>().remesasController.text;
                  List<String> items = remesas.split(",");

                  if (state is DocumentoLoadingState) {
                    return const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 3.0),
                    );
                  }
                  if (state is DocumentoSuccesState) {
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
              )
            ],
          ),
          const SizedBox(height: 8),
          BlocBuilder<FormFacturaBloc, FormFacturaState>(
            builder: (context, state) {
              return (state.error != "") ? ErrorModal(title: state.error) : const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

class _FieldCliente extends StatelessWidget {
  const _FieldCliente({
    Key? key,
    required this.formFacturaBloc,
  }) : super(key: key);

  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    final facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    List<Cliente> clientes = facturaFilterBloc.state.clientes;
    Cliente? cliente = clientes.firstWhereOrNull((element) => element.codigo == formFacturaBloc.clienteCodigo);
    final TextEditingController controller = TextEditingController();
    if (cliente != null) controller.text == cliente.nombre;

    void setValueCliente(EntryAutocomplete entry) {
      formFacturaBloc.setClienteCodigo = entry.codigo;
      controller.text == entry.title;
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Cliente", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        Autocomplete2Input(
          label: "Cliente",
          entries: entries,
          onPressed: setValueCliente,
          controller: controller,
          minChractersSearch: 3,
        )
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

    List<MenuEntry> entryMenus = const [
      MenuEntry(label: "Tipo 10", value: 10),
      MenuEntry(label: "Tipo 12", value: 12),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
          crossAxisAlignment: WrapCrossAlignment.start,
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
    return const CustomColorCard(
      icon: Icons.file_copy_outlined,
      title: "Item Documentos",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildDetailsDocumentos(),
          //Divider(height: 48, color: Colors.white),
          _BuildTableItemsDocumento(),
          Divider(height: 48, color: Colors.white),
          // _BuildPrefacturarDocumento(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _BuildTableItemsDocumento extends StatelessWidget {
  const _BuildTableItemsDocumento();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const CardDetailsFactura()
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
                          child: CardAdicionesAndDescuentos(documentos: documentosDescuentos, title: 'DESCUENTOS', color: Colors.red))
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
        formFacturaBloc.setCentroCosto = value.codigo;
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
                child: Autocomplete2Input(
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
        double totalDocumentos = documentos.fold(0, (total, documento) => total + documento.rcp);
        double totalImpuestos = itemDocumentos.fold(0, (total, item) => total + item.valorIva);
        double totalPrefacturas = itemDocumentos.fold(0, (total, prefactura) => total + prefactura.total);
        double valorFaltante = totalDocumentos - totalPrefacturas;

        bool isTransporte = state.itemDocumentos.any((element) => element.tipo == "TR");
        bool isDocumento = !state.itemDocumentos.any((element) => element.documento <= 0);
        bool isCantidad = !state.itemDocumentos.any((element) => element.cantidad <= 0);
        bool isValor = !state.itemDocumentos.any((element) => element.valor <= 0);
        bool isDescripcion = state.itemDocumentos.any((element) => element.descripcion.isNotEmpty);
        bool isCentroCosto = formFacturaBloc.centroCosto > 0;
        bool isFaltante = valorFaltante.toInt() == 0;

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
                    int centroCosto = formFacturaBloc.centroCosto;
                    int clienteCodigo = formFacturaBloc.clienteCodigo;
                    int empresaCodigo = formFacturaBloc.state.empresa;
                    int usuario = authBloc.state.auth!.usuario.codigo;
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
