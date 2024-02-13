// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/modules/package/factura/data/models/pre_factura_model.dart';

import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/pre_factura.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/widgets/card_adiciones_and_descuentos.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/widgets/modal_item_documento.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/widgets/text_area_documento.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/modals/error_modal.dart';
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
            const WhiteCard(icon: Icons.insert_drive_file_outlined, title: "Factura Documentos", child: TableDocumentos()),
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
    final facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    final formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    List<Empresa> empresas = facturaFilterBloc.state.empresas;

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
              //final empresa = formFacturaBloc.state.empresa;
              const empresa = "1";
              //final cliente = formFacturaBloc.clienteController.text;
              const cliente = "1409";
              //final remesas = formFacturaBloc.remesasController.text;
              //const remesas = "01035-3378,01035-3379,01035-3380,01039-3069";
              //const remesas = "736801,736801,736917,736918,736978,443534,434196,434196,473845,467345";
              const remesas = "736801,736978,443534";
              final inicio = formFacturaBloc.fechaInicioController.text;
              final fin = formFacturaBloc.fechaFinController.text;
              String error = "";
              if (empresa.isEmpty) error += " El campo Empresa no puede ser vacio";
              if (cliente.isEmpty) error += " El campo Cliente no puede ser vacio";
              if (remesas.isEmpty && inicio.isEmpty) error += " Se deben agregar remesas al filtro o un intervalo de fechas";
              if (inicio != "" && fin == "") error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";

              if (error.isNotEmpty) {
                formFacturaBloc.add(ErrorFormFacturaEvent(error));
              }
              //if (isValid && formFacturaBloc.state is FormFacturaRequestState && error.isEmpty) {
              if (isValid && error.isEmpty) {
                final FacturaRequest request = FacturaRequest(
                  empresa: int.parse(empresa),
                  cliente: int.parse(cliente),
                  remesas: remesas,
                  inicio: inicio,
                  fin: fin,
                );
                context.read<FacturaBloc>().add(ActiveteFacturaEvent(request));
                //formFacturaBloc.add(const PanelFormFacturaEvent(false));

                //context.read<FilterFacturaBloc>().add(const PanelFilterFacturaEvent());
              }
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

class _BuildItemFactura extends StatelessWidget {
  const _BuildItemFactura();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
      builder: (context, state) {
        if (state is ItemFacturaSuccesState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _BuildDetailsDocumentos(),
              const SizedBox(height: 24),
              TableItemsFactura(prefacturas: state.preFacturas),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  PreFactura preFactura = PreFacturaModel.init();
                  preFactura.tipo = "SA";
                  context.read<ItemFacturaBloc>().add(AddItemFacturaEvent(preFactura: preFactura));
                },
                icon: const Icon(Icons.add_card_rounded),
                label: const Text("Adicionar"),
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              const _BuildPrefacturarDocumento(),
              const SizedBox(height: 24),
            ],
          );
        }
        return const SizedBox();
      },
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
            ? CardAdicionesAndDescuentos(
                documentos: documentosAdicion,
                title: 'ADICIONES',
                color: Colors.green,
              )
            : const SizedBox(),
        const SizedBox(width: 24),
        documentosDescuentos.isNotEmpty
            ? CardAdicionesAndDescuentos(
                documentos: documentosDescuentos,
                title: 'DESCUENTOS',
                color: Colors.red,
              )
            : const SizedBox(),
      ],
    );
  }
}

class _BuildPrefacturarDocumento extends StatelessWidget {
  const _BuildPrefacturarDocumento();

  @override
  Widget build(BuildContext context) {
    final documentosAll = context.read<FacturaBloc>().state.documentos;
    final controller = TextEditingController();
    final centrosCosto = documentosAll.map((remesa) => MapEntry(remesa.cencosCodigo, remesa.cencosNombre)).toSet().toList();

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
    return BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
      builder: (context, state) {
        bool isValid = context.read<ItemFacturaBloc>().state.preFacturas.any((element) => element.tipo == "TR");
        return SizedBox(
          width: 240,
          child: FilledButton.icon(
            onPressed: isValid && state.centroCosto != "" ? () {} : null,
            icon: const Icon(Icons.add_card_rounded),
            label: const Text("Registrar Pre-Factura"),
          ),
        );
      },
    );
  }
}
