import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';

class ButtonSearchFacturaForm extends StatelessWidget {
  const ButtonSearchFacturaForm({
    required this.formKey,
    required this.itemDocumentoBloc,
    required this.formFacturaBloc,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final ItemDocumentoBloc itemDocumentoBloc;
  final FormFacturaBloc formFacturaBloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        FilledButton.icon(
          onPressed: () {
            final bool isValid = formKey.currentState!.validate();
            itemDocumentoBloc.add(const ResetDocumentoEvent());
            formFacturaBloc.onPressedSearch(isValid: isValid);
          },
          icon: const Icon(Icons.search_rounded),
          label: const Text("Buscar", style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        BlocBuilder<FormFacturaBloc, FormFacturaState>(
          builder: (BuildContext context, FormFacturaState state) {
            if (state is FormFacturaLoadingState) {
              return const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 3.0),
              );
            }
            if (state is FormFacturaLoadingState) {
              final String remesas = context.read<FormFacturaBloc>().remesasController.text;
              final List<String> items = remesas.split(",");
              return Column(
                children: <Widget>[
                  Text(
                    remesas.isEmpty ? "Encontrados" : "Consultadas/Encontrados",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Text(
                    remesas.isEmpty ? "${state.documentos.length}" : "${items.length}/${state.documentos.length}",
                    style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
