import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/data/models/request/pagina_request_model.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/pagina.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/domain/entities/request/pagina_request.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/blocs/pagina_bloc.dart';
import 'package:switrans_2_0/src/packages/maestro/pagina/ui/views/field_modulo.dart';
import 'package:switrans_2_0/src/util/shared/views/build_view_detail.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/inputs_with_titles/segmented_input_title.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/text_input.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class PaginaSearchView extends StatelessWidget {
  const PaginaSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final String fullPath = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    return BlocListener<PaginaBloc, PaginaState>(
      listener: (BuildContext context, PaginaState state) {
        if (state is PaginaExceptionState) {
          ErrorDialog.showDioException(context, state.exception!);
        }
      },
      child: Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(right: 32, top: 8),
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              BuildViewDetail(path: fullPath),
              const WhiteCard(title: "Buscar Registros.", icon: Icons.search, child: _BuildFieldsForm()),
              const _BluildDataTable(),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildFieldsForm extends StatelessWidget {
  const _BuildFieldsForm();
  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController codigoController = TextEditingController();
    final TextEditingController moduloController = TextEditingController();
    bool? isVisible;
    bool? isActivo;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final PaginaBloc paginaBloc = context.read<PaginaBloc>();

    void onPressed() {
      bool isValid = formKey.currentState!.validate();
      final bool isCampoVacio = nombreController.text.isEmpty && codigoController.text.isEmpty && moduloController.text.isEmpty && isVisible == null && isActivo == null;

      if (isCampoVacio) {
        isValid = false;
        paginaBloc.add(const ErrorFormPaginaEvent("Por favor diligenciar por lo menos un campo del formulario"));
      }

      if (isValid) {
        final PaginaRequest request = PaginaRequest(
          nombre: nombreController.text,
          codigo: int.tryParse(codigoController.text),
          modulo: moduloController.text,
          isVisible: isVisible,
          isActivo: isActivo,
        );
        context.read<PaginaBloc>().add(GetPaginaEvent(request));
      }
    }

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BuildFormFields(
            children: <Widget>[
              NumberInputTitle(title: "Codigo", controller: codigoController),
              TextInputTitle(title: "Nombre", controller: nombreController, typeInput: TypeInput.lettersAndNumbers),
              FieldModulo(moduloController),
              SegmentedInputTitle(title: "Visible", onChanged: (bool? newValue) => isVisible = newValue),
              SegmentedInputTitle(title: "Activo", onChanged: (bool? newValue) => isActivo = newValue),
            ],
          ),
          BlocBuilder<PaginaBloc, PaginaState>(
            builder: (BuildContext context, PaginaState state) {
              int cantdiad = 0;
              bool isConsulted = false;
              bool isInProgress = false;
              String error = "";
              if (state is PaginaLoadingState) {
                isInProgress = true;
              }
              if (state is PaginaErrorFormState) {
                error = state.error;
              }
              if (state is PaginaConsultedState) {
                isInProgress = false;
                isConsulted = true;
                cantdiad = state.paginas.length;
              }
              return BuildButtonForm(
                onPressed: onPressed,
                icon: Icons.search,
                label: "Buscar",
                cantdiad: cantdiad,
                isConsulted: isConsulted,
                isInProgress: isInProgress,
                error: error,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BluildDataTable extends StatefulWidget {
  const _BluildDataTable();

  @override
  State<_BluildDataTable> createState() => _BluildDataTableState();
}

class _BluildDataTableState extends State<_BluildDataTable> {
  List<Map<String, dynamic>> listUpdate = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    void onRowChecked(List<Map<String, dynamic>> event) {
      listUpdate.clear();
      setState(() => listUpdate.addAll(event));
    }

    void onPressedSave() {
      for (final Map<String, dynamic> map in listUpdate) {
        final PaginaRequest request = PaginaRequestModel.fromTable(map);
        context.read<PaginaBloc>().add(UpdatePaginaEvent(request));
      }
    }

    Map<String, DataItemGrid> buildPlutoRowData(Pagina pagina) {
      return <String, DataItemGrid>{
        'id': DataItemGrid(type: Tipo.item, value: pagina.id, edit: false),
        'codigo': DataItemGrid(type: Tipo.text, value: pagina.paginaCodigo, edit: false),
        'nombre': DataItemGrid(type: Tipo.text, value: pagina.paginaTexto, edit: true),
        'path': DataItemGrid(type: Tipo.text, value: pagina.paginaPath, edit: false),
        'modulo': DataItemGrid(type: Tipo.text, value: pagina.modulo, edit: false),
        'fecha_creacion': DataItemGrid(type: Tipo.date, value: pagina.fechaCreacion, edit: false),
        'visible': DataItemGrid(type: Tipo.boolean, value: pagina.paginaVisible, edit: true),
        'activo': DataItemGrid(type: Tipo.boolean, value: pagina.paginaActivo, edit: true),
      };
    }

    return BlocBuilder<PaginaBloc, PaginaState>(
      builder: (BuildContext context, PaginaState state) {
        if (state is PaginaConsultedState) {
          final List<Map<String, DataItemGrid>> plutoRes = <Map<String, DataItemGrid>>[];
          for (final Pagina pagina in state.paginas) {
            final Map<String, DataItemGrid> rowData = buildPlutoRowData(pagina);
            plutoRes.add(rowData);
          }
          if (plutoRes.isEmpty) {
            return const Text("No se encontraron resultados...");
          }
          return PlutoGridDataBuilder(plutoData: plutoRes, onRowChecked: onRowChecked, onPressedSave: onPressedSave);
        }
        return const SizedBox();
      },
    );
  }
}
