import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_documentos.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_empresa.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_forms/date_picker_input_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormFacturaBloc, FormFacturaState>(
      listener: (BuildContext context, FormFacturaState state) {
        if (state.status == FormFacturaStatus.error) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, FormFacturaState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8),
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                const BuildViewDetail(),
                CardExpansionPanel(
                  title: "Registrar Nuevo",
                  icon: Icons.storage_outlined,
                  child: _BuildFieldsForm(state),
                ),
                const CardExpansionPanel(
                  title: "Documentos",
                  icon: Icons.folder,
                  child: _BuildDocumentos(),
                ),
                const CardExpansionPanel(
                  title: "Items Documentos",
                  icon: Icons.content_paste_outlined,
                  child: _BuildItemFactura(),
                ),
              ],
            ),
            if (state.status == FormFacturaStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final FormFacturaState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
    final FormFacturaRequest request = formFacturaBloc.request;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            spaces: 2,
            children: <Widget>[
              AutocompleteInputForm(
                entries: state.entriesTiposDocumentos,
                title: "Tipo Documento",
                value: request.documentoCodigo,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.documentoCodigo = result.codigo,
              ),
              AutocompleteInputForm(
                entries: state.entriesClientes,
                title: "Cliente",
                value: request.cliente,
                isRequired: true,
                onChanged: (EntryAutocomplete result) => request.cliente = result.codigo,
              ),
              FieldFacturaEmpresa(
                title: "Empresa",
                value: request.empresa!,
                onChanged: (int result) => request.empresa = result,
              ),
              DatePickerInputForm(
                title: "Fecha Inicio - Fecha Fin",
                value: request.rangoFechas,
                onChanged: (String result) => request.rangoFechas = result,
              ),
              FieldFacturaDocumentos(
                title: "Documentos",
                value: request.documentos,
                onChanged: (String result) => request.documentos = result,
              ),
            ],
          ),
          FormButton(
            onPressed: () async {
              final bool isValid = formKey.currentState!.validate();

              final List<String> fechas = request.rangoFechas!.split(" - ");
              String inicio = "";
              String fin = "";
              final int empresa = state.empresa;
              final List<String> parts = request.documentos!.split(',').map((String e) => e.trim()).toList();
              final String documentos = parts.join(', ');
              if (fechas.length > 1) {
                inicio = fechas[0].trim();
                fin = fechas[1].trim();
              }

              String error = "";
              if (empresa <= 0) {
                error += " El campo Empresa no puede ser vacio";
              }
              if (request.cliente == null) {
                error += " El campo Cliente no puede ser vacio";
              }

              if (documentos.isEmpty && inicio.isEmpty) {
                error +=
                    " Si se selecciona el tipo (Factura 12), se deben incluir documentos en el filtro, o bien, selecciónar un intervalo de fechas";
              }
              if (inicio != "" && fin == "") {
                error += " Si se selecciona el campo fecha Inicio se debe seleccionar fecha Fin";
              }

              if (error.isNotEmpty) {
                formFacturaBloc.add(ErrorFormFacturaEvent(error));
              }

              if (isValid) {
                final FormFacturaRequest request = FormFacturaRequest(
                  empresa: empresa,
                  //cliente: clienteCodigo,
                  cliente: 1228,
                  //documentos: remesas,
                  documentos: "01015-51728",
                  rangoFechas: inicio,
                  documentoCodigo: 11,
                );
                formFacturaBloc.add(DocumentosFormFacturaEvent(request));
              }
            },
            icon: Icons.search_rounded,
            label: "Buscar",
          ),
        ],
      ),
    );
  }
}

class _BuildDocumentos extends StatelessWidget {
  const _BuildDocumentos();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        if (state.status == FormFacturaStatus.succes) {
          final String texto = state.documentos.length == 1 ? "documento encontrado" : "documentos encontrados";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("${state.documentos.length} $texto"),
              state.documentos.isNotEmpty ? TableDocumentos(documentos: state.documentos) : const SizedBox(),
            ],
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _BuildTableItemsDocumento(),
        Divider(height: 48, color: Colors.white),
        _BuildPrefacturarDocumento(),
        SizedBox(height: 24),
      ],
    );
  }
}

class _BuildTableItemsDocumento extends StatelessWidget {
  const _BuildTableItemsDocumento();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onPrimary,
      child: const Column(
        children: <Widget>[
          const TableItemsDocumento(),
          const SizedBox(height: 24),
          CardDetailsFactura(),
        ],
      ),
    );
  }
}

class _BuildPrefacturarDocumento extends StatelessWidget {
  const _BuildPrefacturarDocumento();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormFacturaBloc, FormFacturaState>(
      builder: (BuildContext context, FormFacturaState state) {
        if (state.status == FormFacturaStatus.facturar) {
          final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
          final Empresa empresaSelect = formFacturaBloc.getEmpresaSelected();
          final TextEditingController controllerCentroCosto = TextEditingController();

          final List<MapEntry<int, String>> centrosCosto = context.read<FormFacturaBloc>().getCentosCosto();
          final List<EntryAutocomplete> entriesCentroCosto = centrosCosto.map((MapEntry<int, String> centro) {
            return EntryAutocomplete(
              codigo: centro.key,
              title: centro.value,
              subTitle: '(${centro.key})',
            );
          }).toList();

          void setValueFactura(EntryAutocomplete value) {
            if (value.codigo != null) {
              context.read<ItemDocumentoBloc>().add(const GetItemDocumentoEvent());
            }
          }

          return BlocBuilder<ItemDocumentoBloc, ItemDocumentoState>(
            builder: (BuildContext context, ItemDocumentoState state) {
              if (state is ItemDocumentoSuccesState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const Icon(Icons.work_outline_outlined),
                              const SizedBox(width: 8),
                              Text(empresaSelect.nombre),
                            ],
                          ),
                          const Row(
                            children: <Widget>[
                              Icon(Icons.contact_emergency_outlined),
                              SizedBox(width: 8),
                              Text("ACa va el nombre del cliente"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 400,
                      child: AutocompleteInput(
                        entries: entriesCentroCosto,
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
        } else {
          return const SizedBox();
        }
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
      builder: (BuildContext context, ItemDocumentoState state) {
        final FormFacturaBloc facturaBloc = context.read<FormFacturaBloc>();
        final FormFacturaBloc formFacturaBloc = context.read<FormFacturaBloc>();
        final List<Documento> documentos = facturaBloc.state.documentos;
        final Iterable<ItemDocumento> itemDocumentos = state.itemDocumentos.where((ItemDocumento element) => element.documento > 0);
        final double totalDocumentos = documentos.fold(0, (double total, Documento documento) => total + documento.valorTotal);
        final double totalImpuestos = itemDocumentos.fold(0, (double total, ItemDocumento item) => total + item.valorIva);

        return FormButton(
          label: "Registrar",
          icon: Icons.add_card_rounded,
          onPressed: () {
            //final int centroCosto = formFacturaBloc.centroCosto;
            //final int clienteCodigo = formFacturaBloc.clienteCodigo;
            final int empresaCodigo = formFacturaBloc.state.empresa;
            final int usuario = authBloc.state.auth!.usuario.codigo;
            final PrefacturaRequest prefacturaRequest = PrefacturaRequest(
              centroCosto: 1,
              cliente: 1,
              empresa: empresaCodigo,
              usuario: usuario,
              valorImpuesto: totalImpuestos.toInt(),
              valorNeto: totalDocumentos.toInt(),
              documentos: documentos,
              items: itemDocumentos.toList(),
            );

            debugPrint("${prefacturaRequest.toJson()}");
          },
        );
      },
    );
  }
}
