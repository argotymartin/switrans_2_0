import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/entities/factuta_entities.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';
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
            const CustomExpansionPanel(title: "Filtros", child: BuildFiltros()),
            const SizedBox(height: 10),
            const WhiteCard(icon: Icons.insert_drive_file_outlined, title: "Factura Documentos", child: TableDocumentos()),
            const SizedBox(height: 10),
            const WhiteCard(icon: Icons.file_copy_outlined, title: "Item Factura", child: _BuildItemFactura()),
            const SizedBox(height: 120),
          ],
        ),
        const Positioned(left: 0, right: 0, bottom: -24, child: _ModalItemDocumento()),
      ],
    );
  }
}

class _ModalItemDocumento extends StatefulWidget {
  const _ModalItemDocumento();

  @override
  State<_ModalItemDocumento> createState() => _ModalItemDocumentoState();
}

class _ModalItemDocumentoState extends State<_ModalItemDocumento> with SingleTickerProviderStateMixin {
  late Animation<double> tralateAnimation;
  late FormFacturaBloc formulario;
  @override
  void initState() {
    formulario = context.read<FormFacturaBloc>();
    formulario.animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    tralateAnimation =
        Tween<double>(begin: 50, end: -20).animate(CurvedAnimation(parent: formulario.animationController, curve: Curves.bounceOut));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(right: 24),
      height: 64,
      width: size.width,
      child: AnimatedBuilder(
        animation: formulario.animationController,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, tralateAnimation.value),
          child: InkWell(
            onTap: () => formulario.moveBottomAllScroll(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: BlocBuilder<ItemFacturaBloc, ItemFacturaState>(
                builder: (context, state) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.remesas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(Icons.file_copy),
                              Text("${state.remesas[index].impreso}  (${state.remesas[index].remesa})"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildFiltros extends StatelessWidget {
  const BuildFiltros({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final facturaFilterBloc = BlocProvider.of<FilterFacturaBloc>(context);
    final formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
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

    final titleStyle = GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black87);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
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
                    Text("Cliente", style: titleStyle),
                    const SizedBox(height: 8),
                    AutocompleteInput(
                      title: "Cliente",
                      suggestions: suggestions,
                      controller: formFacturaBloc.clienteController,
                    )
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Empresa", style: titleStyle),
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
                    Text("Remesas", style: titleStyle),
                    const SizedBox(height: 8),
                    _TextAreaRemesas(controller: formFacturaBloc.remesasController),
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
                        Text("Inicio", style: titleStyle),
                        const SizedBox(height: 8),
                        SizedBox(
                            width: size.width * 0.15, height: 56, child: DatetimeInput(controller: formFacturaBloc.fechaInicioController)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fin",
                            style: titleStyle,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                              width: size.width * 0.15, height: 56, child: DatetimeInput(controller: formFacturaBloc.fechaFinController)),
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
              final isValid = formKey.currentState!.validate();
              final empresa = formFacturaBloc.state.empresa;
              final cliente = formFacturaBloc.clienteController.text;
              final remesas = formFacturaBloc.remesasController.text;
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
              if (isValid && formFacturaBloc.state is FormFacturaRequestState && error.isEmpty) {
                final FacturaRequest request = FacturaRequest(
                  //empresa: int.parse(empresa),
                  empresa: 1,
                  //cliente: int.parse(cliente),
                  cliente: 1409,
                  //remesas: remesas,
                  remesas: "01035-3378,01035-3379,01035-3380,01039-3069",
                  //inicio: inicio,
                  //fin: fin,
                );
                context.read<FacturaBloc>().add(ActiveteFacturaEvent(request));
                formFacturaBloc.add(const PanelFormFacturaEvent(false));

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
    RegExp regexGeneral = RegExp(r'^\d{7}$');
    RegExp regexImpreso = RegExp(r'^\d{2,5}-\d+$');

    if (regexGeneral.hasMatch(remesas.first)) {
      regexRemesas = regexGeneral;
      title = "General";
    } else if (regexImpreso.hasMatch(remesas.first)) {
      regexRemesas = regexImpreso;
      title = "Impreso";
    } else {
      return "Los valores digitados no parecen ser remesas validas";
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
