import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/blocs/factura/factura_bloc.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/widgets/breadcrumb_trail.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/widgets/card_empresa.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});

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
        WhiteCard(
          title: 'Factura',
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.35,
                      child: AutocompleteInput(
                        processFunction: getClienteByParam,
                        labelText: "Cliente",
                        incomingController: controllerCliente,
                      ),
                    ),
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
                    SizedBox(
                      width: size.width * 0.35,
                      height: 36,
                      child: FutureBuilder(
                        future: facturaBloc.getEmpresas(),
                        builder: (context, AsyncSnapshot<List<Empresa>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                final empresa = snapshot.data![i];
                                return BuildCardEmpresa(empresa: empresa);
                              },
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
