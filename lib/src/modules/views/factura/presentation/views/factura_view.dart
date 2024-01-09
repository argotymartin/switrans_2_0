import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/labels/custom_label.dart';
import 'package:switrans_2_0/src/modules/views/factura/presentation/blocs/cliente/cliente_bloc.dart';

class FacturaView extends StatelessWidget {
  const FacturaView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerCliente = TextEditingController();
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        Row(
          children: [
            Text("SmartAdmin", style: TextStyle(color: Colors.blue.shade500)),
            const SizedBox(width: 4),
            const Text("/"),
            const SizedBox(width: 4),
            Text("Theme Settings", style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(width: 4),
            const Text("/"),
            const SizedBox(width: 4),
            Text("How it works", style: TextStyle(color: Colors.grey.shade600)),
            const Spacer(),
            Text("Monday, January 8, 2024", style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
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
          title: 'Sales Statistics',
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 400,
                      height: 120,
                      child: BlocBuilder<ClienteBloc, ClienteState>(
                        builder: (context, state) {
                          Future<List<String?>> newMethod(String search) async {
                            context.read<ClienteBloc>().add(ActiveteClienteEvent(search));
                            final namesClientes = state.clientes.map((cliente) => cliente.nombre);
                            return namesClientes.toList();
                          }

                          return AutocompleteInput(
                            processFunction: newMethod,
                            labelText: "Cliente",
                            incomingController: controllerCliente,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 400,
                      height: 120,
                      child: BlocBuilder<ClienteBloc, ClienteState>(
                        builder: (context, state) {
                          Future<List<String?>> newMethod(String search) async {
                            context.read<ClienteBloc>().add(ActiveteClienteEvent(search));
                            final namesClientes = state.clientes.map((cliente) => cliente.nombre);
                            return namesClientes.toList();
                          }

                          return AutocompleteInput(
                            processFunction: newMethod,
                            labelText: "Comercial",
                            incomingController: controllerCliente,
                          );
                        },
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
