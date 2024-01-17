import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/build_view_detail.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/pluto_grid_custom.dart';

import 'package:switrans_2_0/src/modules/shared/widgets/cards/white_card.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/autocomplete_input.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/cliente.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/empresa.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/blocs/filters_factura/filters_factura_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/card_empresa.dart';
import 'package:switrans_2_0/src/modules/package/factura/presentation/widgets/datetime_input.dart';

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
        WhiteCard(title: 'Filtros', child: BuildFiltros()),
        SizedBox(height: 10),
        WhiteCard(title: "Resultado", child: BuildColumn()),
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
    final facturaFilterBloc = BlocProvider.of<FiltersFacturaBloc>(context);
    List<Cliente> clientes = facturaFilterBloc.state.clientes;
    List<Empresa> empresas = facturaFilterBloc.state.empresas;
    final empresasl = empresas.map((empresa) => SizedBox(width: 180, child: BuildCardEmpresa(empresa: empresa))).toList();

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
                  Text("Remesas", style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const _TextAreaRemesas(),
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
                      SizedBox(width: size.width * 0.15, height: 56, child: const DatetimeInput()),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fin", style: Theme.of(context).textTheme.titleLarge),
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

class _TextAreaRemesas extends StatelessWidget {
  const _TextAreaRemesas();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: onValidator,
      minLines: 4,
      style: const TextStyle(fontSize: 12),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
        labelText: 'Numeros de remesa (General / Impreso) separados por (,)',
      ),
    );
  }

  String? onValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    RegExp regexCon = RegExp(r'^\d+$');
    RegExp regexImp = RegExp(r'^\d{2,5}-\d+$');
    RegExp regex = RegExp(r'^[0-9,-]+$');

    if (!regex.hasMatch(value)) {
      return "No se permiten valores de texto";
    }

    List<String> remesas = value.split(",").map((remesa) => remesa.trim()).toList();

    String title = "";

    RegExp regexRemesas = (regexCon.hasMatch(remesas.first))
        ? regexCon
        : (regexImp.hasMatch(remesas.first))
            ? regexImp
            : RegExp("");

    List<String> remesasDiferentes = remesas.where((elemento) => !regexRemesas.hasMatch(elemento)).toList();

    if (remesasDiferentes.isNotEmpty) {
      if (remesasDiferentes.first != "" && remesasDiferentes.length > 1) {
        return "Las remesas (${remesasDiferentes.toList()}) No son válidas para el tipo $title";
      } else {
        //return "La remesa (${remesasDiferentes.first.replaceAll(",", "")}) No es valida para el conjunto de códigos con formato $title";
      }
    }

    return null;
  }
}

class BuildColumn extends StatelessWidget {
  const BuildColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const PlutoGridCustom();
  }
}
