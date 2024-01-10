import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/blocs/cliente/cliente_bloc.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});
  @override
  Widget build(BuildContext context) {
    List<Cliente> clientes = [];
    final clienteBloc = BlocProvider.of<ClienteBloc>(context);
    final size = MediaQuery.of(context).size;
    TextEditingController controllerCliente = TextEditingController();

    Future<List<String?>> getClienteByParam(String search) async {
      await Future.delayed(const Duration(milliseconds: 500));
      final clientes2 = await clienteBloc.getCliente(search);
      final namesClientes = clientes2.map((cliente) => cliente.nombre);
      return namesClientes.toList();
    }

    Future<List<String?>> getClientesAll(String search) async {
      final namesClientes = clientes.map((cliente) => cliente.nombre);
      return namesClientes.where((cliente) {
        final nameCliente = cliente.toLowerCase();
        final query = search.toLowerCase();
        return nameCliente.contains(query);
      }).toList();
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
                    InkWell(
                      onFocusChange: (value) async {
                        if (value) clientes = await clienteBloc.getClientesAll();
                      },
                      child: SizedBox(
                        width: size.width * 0.35,
                        child: AutocompleteInput(
                          processFunction: getClientesAll,
                          labelText: "Cliente",
                          incomingController: controllerCliente,
                        ),
                      ),
                    ),
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

class BreadcrumbTrail extends StatelessWidget {
  final List<String> elements;
  const BreadcrumbTrail({
    super.key,
    required this.elements,
  });

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
    List<Widget> result = [];
    bool primeraIteracion = true;
    for (var element in elements) {
      if (primeraIteracion) {
        result.add(Text(element, style: TextStyle(color: Colors.blue.shade500)));
        primeraIteracion = false; // Cambiar la variable para evitar repetir la acción
      } else {
        result.add(Text(element, style: TextStyle(color: Colors.grey.shade500)));
      }

      result.add(const SizedBox(width: 4));
      result.add(const Text("/"));
      result.add(const SizedBox(width: 4));
    }
    return Row(
      children: [
        Row(children: result),
        const Spacer(),
        Text(formattedDate, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
