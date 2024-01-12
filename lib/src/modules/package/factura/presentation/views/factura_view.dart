import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/datasorces/datatables/factura_datasorces.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/blocs/filters_factura/filters_factura_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/breadcrumb_trail.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/card_empresa.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/datetime_input.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        const BreadcrumbTrail(elements: ["SmartAdmin", "Admin", "Theme Settings"]),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.document_scanner_outlined, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text('Factura', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
        Text("Sistema de gestión de facturas que permite la facturación de servicios para diversos clientes con facilidad",
            style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: 10),
        Column(
          children: [
            const WhiteCard(
              title: 'Filtros',
              child: BuildFiltros(),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: PaginatedDataTable(
                header: const Text("Remesas Disponibles"),
                dataRowMaxHeight: 100,
                showCheckboxColumn: true,
                sortAscending: true,
                columns: const [
                  DataColumn(label: Text("Item")),
                  DataColumn(label: Text("Remesa")),
                  DataColumn(label: Text("Flete")),
                  DataColumn(label: Text("Obs")),
                  DataColumn(label: Text("Remision")),
                  DataColumn(label: Text("Otros")),
                  DataColumn(label: Text("Tarifa")),
                  DataColumn(label: Text("Total")),
                  DataColumn(label: Text("Accion")),
                ],
                headingRowColor: const MaterialStatePropertyAll(Colors.white),
                source: FacturaDatasources(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BuildFiltros extends StatefulWidget {
  const BuildFiltros({
    super.key,
  });

  @override
  State<BuildFiltros> createState() => _BuildFiltrosState();
}

class _BuildFiltrosState extends State<BuildFiltros> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final facturaFilterBloc = BlocProvider.of<FiltersFacturaBloc>(context);
    List<Cliente> clientes = facturaFilterBloc.state.clientes;
    List<Empresa> empresas = facturaFilterBloc.state.empresas;
    final empresasl = empresas.map((empresa) {
      return SizedBox(width: 160, child: BuildCardEmpresa(empresa: empresa));
    }).toList();

    final suggestions = clientes.map((cliente) {
      return SuggestionModel(
          codigo: cliente.codigo.toString(),
          title: cliente.nombre,
          subTitle: cliente.identificacion,
          details: Row(children: [const Icon(Icons.call_rounded), Text(cliente.identificacion)]));
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cliente", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  AutocompleteInput(
                    suggestions: suggestions,
                  )
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Empresa", style: CustomLabels.h3),
                  const SizedBox(height: 8),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 12,
                    children: empresasl,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Remesas", style: CustomLabels.h3),
                  const SizedBox(height: 8),
                  TextFormField(
                    minLines: 4,
                    style: const TextStyle(fontSize: 12),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      //labelText: 'Ingrese los numeros de Remesas',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                children: [
                  //const SizedBox(width: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Inicio", style: CustomLabels.h3),
                        const SizedBox(height: 8),
                        SizedBox(width: size.width * 0.15, height: 56, child: const DatetimeInput()),
                      ],
                    ),
                  ),
                  //const SizedBox(width: 24),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fin", style: CustomLabels.h3),
                        const SizedBox(height: 8),
                        SizedBox(width: size.width * 0.15, height: 56, child: const DatetimeInput()),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded),
          label: const Text("Buscar", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
