import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/package/factura/domain/factura_domain.dart';
import 'package:switrans_2_0/src/modules/package/factura/ui/factura_ui.dart';

// DropdownMenuEntry labels and values for the second dropdown menu.
class FacturaSearchView extends StatelessWidget {
  const FacturaSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController iconController = TextEditingController();
    final facturaFilterBloc = BlocProvider.of<FormFacturaBloc>(context);
    List<Cliente> clientes = facturaFilterBloc.state.clientes;
    List<EntiresAutocomplete> entries = clientes.map((cliente) {
      return EntiresAutocomplete(
        title: cliente.nombre,
        subTitle: cliente.identificacion,
        codigo: cliente.codigo,
        details: Row(
          children: [
            const Icon(Icons.call, size: 16),
            Text(cliente.telefono, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w100)),
          ],
        ),
      );
    }).toList();

    final dropdownMenuEntries = entries.map<DropdownMenuEntry<EntiresAutocomplete>>(
      (entry) {
        return DropdownMenuEntry<EntiresAutocomplete>(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(EdgeInsets.all(8)),
            side: MaterialStatePropertyAll(BorderSide(color: Colors.grey, width: 0.3)),
          ),
          value: entry,
          label: entry.title,
          leadingIcon: CircleAvatar(child: Text('${entry.codigo}')),
          labelWidget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
              Text(entry.title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              entry.details,
            ],
          ),
        );
      },
    ).toList();
    return SafeArea(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<EntiresAutocomplete>(
                  controller: iconController,
                  enableFilter: true,
                  requestFocusOnTap: true,
                  leadingIcon: const Icon(Icons.search),
                  label: const Text('Cliente'),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (EntiresAutocomplete? cliente) {},
                  dropdownMenuEntries: dropdownMenuEntries,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EntiresAutocomplete {
  final String title;
  final int codigo;
  final String subTitle;
  final Widget details;
  EntiresAutocomplete({
    required this.title,
    required this.subTitle,
    this.details = const SizedBox(width: 1, height: 1),
    this.codigo = 0,
  });
}
