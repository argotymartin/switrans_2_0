import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';
import 'package:switrans_2_0/src/modules/views/factura/data/datasorces/datatables/factura_datasorces.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/blocs/factura/factura_bloc.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/widgets/breadcrumb_trail.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/widgets/card_empresa.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/widgets/datetime_input.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});

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
            Text('Factura', style: CustomLabels.h1),
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

class BuildFiltros extends StatelessWidget {
  const BuildFiltros({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Cliente> clientes = [];
    final size = MediaQuery.of(context).size;
    TextEditingController controllerCliente = TextEditingController();
    final facturaBloc = BlocProvider.of<FacturaBloc>(context);
    Future<List<String?>> getClienteByParam(String search) async {
      await Future.delayed(const Duration(milliseconds: 500));
      final clientes2 = await facturaBloc.getCliente(search);
      final namesClientes = clientes2.map((cliente) => cliente.nombre);
      return namesClientes.toList();
    }

    Future<List<String?>> getClientesAll(String search) async {
      if (search.length >= 2) {
        final namesClientes = clientes.map((cliente) => cliente.nombre);
        return namesClientes.where((cliente) {
          final nameCliente = cliente.toLowerCase();
          final query = search.toLowerCase();
          return nameCliente.contains(query);
        }).toList();
      }
      return [];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cliente", style: CustomLabels.h3),
                const SizedBox(height: 8),
                SizedBox(
                  width: size.width * 0.35,
                  child: AutocompleteInput(
                    processFunction: getClienteByParam,
                    labelText: "Cliente",
                    incomingController: controllerCliente,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            /*InkWell(
              onFocusChange: (value) async {
                if (value) clientes = await facturaBloc.getClientesAll();
              },
              child: SizedBox(
                width: size.width * 0.35,
                child: AutocompleteInput(
                  processFunction: getClientesAll,
                  labelText: "Cliente",
                  incomingController: controllerCliente,
                ),
              ),
            ),*/
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Empresa", style: CustomLabels.h3),
                const SizedBox(height: 8),
                FutureBuilder(
                  future: facturaBloc.getEmpresas(),
                  builder: (context, AsyncSnapshot<List<Empresa>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                        width: size.width * 0.35,
                        height: 56,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            final empresa = snapshot.data![i];
                            return BuildCardEmpresa(empresa: empresa);
                          },
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Remesas", style: CustomLabels.h3),
                const SizedBox(height: 8),
                SizedBox(
                  width: size.width * 0.35,
                  child: TextFormField(
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
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Inicio", style: CustomLabels.h3),
                    const SizedBox(height: 8),
                    SizedBox(width: size.width * 0.15, height: 56, child: const DatetimeInput()),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Fin", style: CustomLabels.h3),
                    const SizedBox(height: 8),
                    SizedBox(width: size.width * 0.15, height: 56, child: const DatetimeInput()),
                  ],
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.indigo.shade300;
            }
            return Colors.indigo;
          })),
          onPressed: () {
            print("Enviar peticion");
          },
          icon: const Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
          label: const Text("Buscar", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
