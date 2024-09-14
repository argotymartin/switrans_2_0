import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/entities/impuesto.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_documentos.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/field_factura_empresa.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/views/widgets/table_total_documento.dart';
import 'package:switrans_2_0/src/util/shared/models/models_shared.dart';
import 'package:switrans_2_0/src/util/shared/views/views_shared.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_forms/date_picker_input_form.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class FacturaCreateView extends StatelessWidget {
  const FacturaCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FacturaBloc, FacturaState>(
      listener: (BuildContext context, FacturaState state) {
        if (state.status == FacturaStatus.exception) {
          CustomToast.showError(context, state.exception!);
        }
      },
      builder: (BuildContext context, FacturaState state) {
        return Stack(
          children: <Widget>[
            ListView(
              padding: const EdgeInsets.only(right: 32, top: 8, bottom: 24),
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
                const SizedBox(height: 200),
              ],
            ),
            if (state.status == FacturaStatus.loading) const LoadingModal(),
          ],
        );
      },
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  final FacturaState state;
  const _BuildFieldsForm(this.state);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final FacturaBloc facturaBloc = context.read<FacturaBloc>();
    final FormFacturaRequest request = facturaBloc.request;
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
              String error = "";

              if (request.empresa == null) {
                error += " El campo Empresa no puede ser vacio";
              }
              if (request.cliente == null) {
                error += " El campo Cliente no puede ser vacio";
              }

              if (request.documentoCodigo == null) {
                error += " El campo tipo Documento no puede ser vacio";
              }
              if (request.cliente == null) {
                error += " El campo Cliente no puede ser vacio";
              }

              if (request.documentos != null) {
                final List<String> parts = request.documentos!.split(',').map((String e) => e.trim()).toList();
                final String documentos = parts.join(', ');
                request.documentos = documentos;
              }

              if (request.documentos!.isEmpty && request.rangoFechas!.isEmpty) {
                error += " Se deben incluir documentos en el filtro, o bien, selecciónar un intervalo de fechas";
              }

              if (error.isNotEmpty) {
                facturaBloc.add(ErrorFacturaEvent(error));
              }

              if (isValid) {
                facturaBloc.add(GetDocumentosFacturaEvent(request));
              }
            },
            icon: Icons.search_rounded,
            label: "Buscar",
          ),
          state.status == FacturaStatus.error ? ErrorModal(title: state.error) : const SizedBox(),
        ],
      ),
    );
  }
}

class _BuildDocumentos extends StatelessWidget {
  const _BuildDocumentos();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        if (state.status == FacturaStatus.succes) {
          final String texto = state.documentos.length == 1 ? "documento encontrado" : "documentos encontrados";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${state.documentos.length} $texto",
                style: TextStyle(
                  color: AppTheme.colorTextTheme,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
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
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        if (state.status == FacturaStatus.succes) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _BuildTableItemsDocumento(state),
              const _BuildPrefacturarDocumento(),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildTableItemsDocumento extends StatelessWidget {
  final FacturaState state;
  const _BuildTableItemsDocumento(this.state);

  @override
  Widget build(BuildContext context) {
    return state.documentosSelected.isNotEmpty
        ? ColoredBox(
            color: Theme.of(context).colorScheme.onPrimary,
            child: const Column(
              children: <Widget>[
                const TableItemsDocumento(),
                const SizedBox(height: 24),
              ],
            ),
          )
        : const SizedBox();
  }
}

class _BuildPrefacturarDocumento extends StatelessWidget {
  const _BuildPrefacturarDocumento();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        if (state.status == FacturaStatus.succes) {
          if (state.documentosSelected.isNotEmpty) {
            final FacturaBloc facturaBloc = context.read<FacturaBloc>();
            final FormFacturaRequest request = facturaBloc.request;
            final Empresa empresaSelect = state.empresas.firstWhere((Empresa element) => element.codigo == state.empresa);
            final EntryAutocomplete cliente =
                state.entriesClientes.firstWhere((EntryAutocomplete element) => element.codigo == request.cliente);

            final List<MapEntry<int, String>> centrosCosto = context.read<FacturaBloc>().getCentosCosto();
            final List<EntryAutocomplete> entriesCentroCosto = centrosCosto.map((MapEntry<int, String> centro) {
              return EntryAutocomplete(
                codigo: centro.key,
                title: centro.value,
              );
            }).toList();

            void setValueFactura(EntryAutocomplete value) {
              if (value.codigo != null) {
                facturaBloc.request.centroCostoCodigo = value.codigo;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: BuildFormFields(
                crossAxisAlignment: CrossAxisAlignment.end,
                spaces: 2,
                children: <Widget>[
                  const TableTotalDocumento(),
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    spacing: 16,
                    runSpacing: 16,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 300,
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
                            Row(
                              children: <Widget>[
                                const Icon(Icons.contact_emergency_outlined),
                                const SizedBox(width: 8),
                                Text(cliente.title),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        child: AutocompleteInput(
                          entries: entriesCentroCosto,
                          entryCodigoSelected: entriesCentroCosto.first.codigo,
                          onPressed: setValueFactura,
                        ),
                      ),
                      const _BuildButtonRegistrar(),
                    ],
                  ),
                ],
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}

class _BuildButtonRegistrar extends StatelessWidget {
  const _BuildButtonRegistrar();

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();

    return BlocBuilder<FacturaBloc, FacturaState>(
      builder: (BuildContext context, FacturaState state) {
        final Map<String, double> mapImpuestos = <String, double>{};
        final List<Documento> documentos = state.documentosSelected;
        double total = 0;
        double subTotal = 0;
        for (final Documento doc in documentos) {
          for (final ItemDocumento item in doc.itemDocumentos) {
            subTotal += item.subtotal;
            total += item.total;
          }
          for (final Impuesto imp in doc.impuestos) {
            mapImpuestos.update(
              imp.nombre,
              (double existingValue) => existingValue + imp.valor,
              ifAbsent: () => imp.valor,
            );
          }
        }

        return FormButton(
          label: "Registrar",
          icon: Icons.add_card_rounded,
          onPressed: () async {
            final FacturaBloc facturaBloc = context.read<FacturaBloc>();

            await Future<dynamic>.delayed(const Duration(seconds: 1));
            final int usuario = authBloc.state.auth!.usuario.codigo;
            final FacturaRequest facturaRequest = FacturaRequest(
              tipoDocumento: facturaBloc.request.documentoCodigo!,
              centroCosto: facturaBloc.request.centroCostoCodigo!,
              cliente: facturaBloc.request.cliente!,
              empresa: facturaBloc.request.empresa!,
              usuario: usuario,
              items: documentos.toList(),
              impuestos: mapImpuestos,
              subtotal: subTotal,
              total: total,
            );

            debugPrint("${facturaRequest.toJson()}");
          },
        );
      },
    );
  }
}
