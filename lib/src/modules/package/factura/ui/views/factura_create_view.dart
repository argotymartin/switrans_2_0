import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

import 'package:switrans_2_0/src/modules/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: const [
        BuildViewDetail(
          title: "Factura",
          detail: "Sistema de gestión de facturas que permite la facturación de servicios para diversos clientes con facilidad",
          breadcrumbTrails: ["SmartAdmin", "Admin", "Theme Settings"],
        ),
        SizedBox(height: 10),
        CustomExpansionPanel(title: "Filtros", child: BuildFiltros()),
        SizedBox(height: 10),
        WhiteCard(icon: Icons.file_copy_outlined, title: "Item Factura", child: _BuildItemFactura()),
        SizedBox(height: 10),
        WhiteCard(icon: Icons.insert_drive_file_outlined, title: "Factura Documentos", child: TableRemesas()),
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
    final size = MediaQuery.of(context).size;
    final clienteController = TextEditingController();
    final remesasController = TextEditingController();
    final fechaInicioController = TextEditingController();
    final fechaFinController = TextEditingController();
    List<int> empresasSelect = [];
    final facturaFilterBloc = BlocProvider.of<FilterFacturaBloc>(context);
    List<Cliente> clientes = facturaFilterBloc.state.clientes;
    List<Empresa> empresas = facturaFilterBloc.state.empresas;

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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Cliente", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  AutocompleteInput(
                    title: "Cliente",
                    suggestions: suggestions,
                    controller: clienteController,
                  )
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Empresa", style: Theme.of(context).textTheme.titleLarge),
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
                          empresasSelect: empresasSelect,
                        ),
                      ),
                    ),
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
                  Text("Remesas", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  _TextAreaRemesas(controller: remesasController),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Inicio", style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      SizedBox(width: size.width * 0.15, height: 56, child: DatetimeInput(controller: fechaInicioController)),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fin", style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 8),
                        SizedBox(width: size.width * 0.15, height: 56, child: DatetimeInput(controller: fechaFinController)),
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
          onPressed: () {
            final remesasFilter = RemesaFilterRequest(
              cliente: int.parse(clienteController.text),
              empresas: empresasSelect,
              remesas: remesasController.text,
              inicio: fechaInicioController.text,
              fin: fechaInicioController.text,
            );
            print(remesasFilter);
          },
          icon: const Icon(Icons.search_rounded),
          label: const Text("Buscar", style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}

class _TextAreaRemesas extends StatelessWidget {
  final TextEditingController controller;
  const _TextAreaRemesas({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.always,
      validator: onValidator,
      minLines: 4,
      style: const TextStyle(fontSize: 12),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        errorMaxLines: 2,
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText: 'Numeros de remesa (General / Impreso) separados por (,)',
      ),
    );
  }

  String? onValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    RegExp regexRemesas = RegExp("");

    RegExp regex = RegExp(r'^[0-9, -]+$');
    if (!regex.hasMatch(value)) return "Los valores de texto no estan permitidos";
    List<String> remesas = value
        .split(",")
        .map((remesa) => remesa.trim())
        .takeWhile((remesa) => remesa != value.split(",").last.trim())
        .where((remesa) => regexRemesas.hasMatch(remesa))
        .toList();
    if (remesas.isEmpty) return null;
    String title = "";
    RegExp regexGeneral = RegExp(r'^\d+$');
    RegExp regexImpreso = RegExp(r'^\d{2,5}-\d+$');

    if (regexGeneral.hasMatch(remesas.first)) {
      regexRemesas = regexGeneral;
      title = "General";
    }

    if (regexImpreso.hasMatch(remesas.first)) {
      regexRemesas = regexImpreso;
      title = "Impreso";
    }

    List<String> remesasDiferentes = remesas.where((remesa) => !regexRemesas.hasMatch(remesa)).toList();

    if (remesasDiferentes.isNotEmpty) {
      if (remesasDiferentes.first != "") {
        return "Las remesas (${remesasDiferentes.toList()}) No son válidas para el tipo $title";
      }
    }

    return null;
  }
}

class _BuildItemFactura extends StatelessWidget {
  const _BuildItemFactura();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
      builder: (context, state) {
        if (state is ItemFacturaSuccesState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: TableItemsFactura(remesas: state.remesas),
              ),
              //Expanded(child: Container(height: 200, color: Colors.black)),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
