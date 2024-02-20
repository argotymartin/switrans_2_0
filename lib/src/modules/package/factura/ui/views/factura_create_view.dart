import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    List<String> names = fullPath.split("/");
    final formularioBloc = context.read<FormFacturaBloc>();
    return Stack(
      children: [
        ListView(
          controller: formularioBloc.scrollController,
          padding: const EdgeInsets.only(right: 24, top: 8),
          physics: const ClampingScrollPhysics(),
          children: [
            BuildViewDetail(
              title: "Factura",
              detail: "Sistema de gestión de facturas que permite la facturación de servicios para diversos clientes con facilidad",
              breadcrumbTrails: names,
            ),
            const SizedBox(height: 10),
            const CustomExpansionPanel(title: "Filtros", child: _BuildFiltros()),
            const SizedBox(height: 10),
            const WhiteCard(icon: Icons.insert_drive_file_outlined, title: "Factura Documentos", child: _BuildDocumentos()),
            const SizedBox(height: 10),
            const WhiteCard(icon: Icons.file_copy_outlined, title: "Item Factura", child: _BuildItemFactura()),
            const SizedBox(height: 200),
          ],
        ),
        const Positioned(left: 0, right: 0, bottom: -24, child: ModalItemDocumento()),
      ],
    );
  }
}

class _BuildFiltros extends StatelessWidget {
  const _BuildFiltros();

  @override
  Widget build(BuildContext context) {
    final formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
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
              Expanded(child: _FieldCliente(formFacturaBloc: formFacturaBloc)),
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
          FilledButton.icon(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              formFacturaBloc.onPressedSearch(isValid);
            },
            icon: const Icon(Icons.search_rounded),
            label: const Text("Buscar", style: TextStyle(color: Colors.white)),
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

    final suggestions = clientes.map((cliente) {
      return SuggestionModel(
        codigo: cliente.codigo.toString(),
        title: cliente.nombre,
        subTitle: cliente.identificacion,
        details: Row(children: [const Icon(Icons.call_rounded), Text(cliente.identificacion)]),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Cliente", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        AutocompleteInput(
          title: "Cliente",
          suggestions: suggestions,
          controller: formFacturaBloc.clienteController,
        )
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
          spacing: 12,
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
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (context, state) {
        if (state is FacturaSuccesState) {
          final remesas = context.read<FormFacturaBloc>().remesasController.text;
          List<String> items = remesas.split(",");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text(
                    "Consultadas/Encontrados",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    "${items.length}/${state.documentos.length}",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TableDocumentos(documentos: state.documentos),
            ],
          );
        }
        if (state is FacturaLoadingState) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/animations/loading.gif"),
                const Text("Por favor espere........."),
              ],
            ),
          );
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const _BuildDetailsDocumentos(),
        const SizedBox(height: 16),
        const TableItemsDocumento(),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.read<ItemFacturaBloc>().add(const AddItemServicioAdicionalFacturaEvent()),
              icon: const Icon(Icons.add_card_rounded),
              label: const Text("Adicionar"),
            ),
            const CardDetailsFactura()
          ],
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 12),
        const SizedBox(height: 12),
        const _BuildPrefacturarDocumento(),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _BuildDetailsDocumentos extends StatelessWidget {
  const _BuildDetailsDocumentos();

  @override
  Widget build(BuildContext context) {
    final documentos = context.read<FacturaBloc>().state.documentos;
    final documentosAdicion = documentos.where((remesa) => remesa.adiciones.isNotEmpty).toList();
    final documentosDescuentos = documentos.where((remesa) => remesa.descuentos.isNotEmpty).toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        documentosAdicion.isNotEmpty
            ? Expanded(child: CardAdicionesAndDescuentos(documentos: documentosAdicion, title: 'ADICIONES', color: Colors.green))
            : const Expanded(child: SizedBox()),
        const SizedBox(width: 48),
        documentosDescuentos.isNotEmpty
            ? Expanded(child: CardAdicionesAndDescuentos(documentos: documentosDescuentos, title: 'DESCUENTOS', color: Colors.red))
            : const Expanded(child: SizedBox()),
      ],
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
    final controller = TextEditingController();

    final centrosCosto = context.read<FacturaBloc>().getCentosCosto();
    final suggestions = centrosCosto.map((centro) {
      return SuggestionModel(
        codigo: '${centro.key}',
        title: centro.value,
        subTitle: '(${centro.key})',
      );
    }).toList();
    void setValueFactura(String value) {
      if (value.isNotEmpty) {
        context.read<ItemFacturaBloc>().add(SelectCentroCostoItemFacturaEvent(centroCosto: value));
      }
    }

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
            suggestions: suggestions,
            title: "Centro Costo",
            controller: controller,
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
}

class _BuildButtonRegistrar extends StatelessWidget {
  const _BuildButtonRegistrar();

  @override
  Widget build(BuildContext context) {
    final FacturaBloc facturaBloc = context.read<FacturaBloc>();
    final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
    final AuthBloc authBloc = context.read<AuthBloc>();

    return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
      builder: (context, state) {
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
        bool isCentroCosto = state.centroCosto.isNotEmpty;
        bool isFaltante = valorFaltante.toInt() == 0;

        /*debugPrint("isTransporte: $isTransporte");
        debugPrint("isDocumento: $isDocumento");
        debugPrint("isCantidad: $isCantidad");
        debugPrint("isValor: $isValor");
        debugPrint("isDescripcion: $isDescripcion");
        debugPrint("isCentroCosto: $isCentroCosto");
        debugPrint("isFaltante: $isFaltante");
        debugPrint("valorFaltante: ${valorFaltante.toInt()}");
        debugPrint("***********************");*/

        return SizedBox(
          width: 240,
          child: FilledButton.icon(
            onPressed: isDocumento && isTransporte && isCentroCosto && isCantidad && isValor && isDescripcion && isFaltante
                ? () {
                    int centroCosto = int.parse(state.centroCosto);
                    int clienteCodigo = int.parse(formFacturaBloc.clienteController.text);
                    int empresaCodigo = int.parse(formFacturaBloc.state.empresa);
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
