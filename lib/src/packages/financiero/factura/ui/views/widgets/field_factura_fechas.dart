import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/packages/financiero/factura/ui/factura_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/inputs/web_date_picker2.dart';

class FieldFacturaFechas extends StatelessWidget {
  const FieldFacturaFechas({super.key});

  @override
  Widget build(BuildContext context) {
    final FormFacturaBloc formFacturaBloc = BlocProvider.of<FormFacturaBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(" Fecha Inicio - Fecha Fin", style: AppTheme.titleStyle),
        const SizedBox(height: 8),
        WebDatePicker2(
          controller: formFacturaBloc.fechacontroller,
        ),
      ],
    );
  }
}
