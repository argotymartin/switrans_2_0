import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/views/factura/domain/entities/cliente.dart';

class InputSearch extends StatefulWidget {
  const InputSearch({
    super.key,
  });

  @override
  State<InputSearch> createState() => _InputSearchState();
}

List<Cliente> clientes = [
  Cliente(codigo: 1, nombre: "Alimentos polar", nit: "107356464"),
  Cliente(codigo: 2, nombre: "Geodis", nit: "654155"),
  Cliente(codigo: 3, nombre: "Doctor Audio", nit: "8080888"),
  Cliente(codigo: 4, nombre: "Exito", nit: "107356464"),
  Cliente(codigo: 5, nombre: "Coopidrogas", nit: "10735556"),
  Cliente(codigo: 6, nombre: "DSV", nit: "7356464"),
];

class _InputSearchState extends State<InputSearch> {
  TextEditingController controller = TextEditingController();
  List<Cliente> allClientes = clientes;
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: TextField(
            controller: controller,
            onChanged: searchValueChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search_outlined),
              hintText: "Buscar Cliente",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  )),
            ),
          ),
        ),
        isSearch
            ? SizedBox(
                height: 300,
                width: 300,
                child: ListView.builder(
                  itemCount: allClientes.length,
                  itemBuilder: (context, index) {
                    final cliente = allClientes[index];
                    return ListTile(
                      title: Text(cliente.nombre),
                    );
                  },
                ))
            : const SizedBox(),
      ],
    );
  }

  void searchValueChanged(String query) {
    final suggestions = clientes.where((cliente) {
      final clienteNombre = cliente.nombre.toLowerCase();
      return clienteNombre.contains(query.toLowerCase());
    }).toList();
    setState(() {
      allClientes = suggestions;
      isSearch = true;
    });
  }
}
