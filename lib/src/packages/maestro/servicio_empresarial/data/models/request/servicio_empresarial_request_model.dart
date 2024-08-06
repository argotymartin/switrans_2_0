import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';

class ServicioEmpresarialRequestModel extends ServicioEmpresarialRequest {
  ServicioEmpresarialRequestModel({
    super.codigo,
    super.esActivo,
    super.nombre,
    super.usuario,
  });

  factory ServicioEmpresarialRequestModel.fromTable(Map<String, dynamic> map) => ServicioEmpresarialRequestModel(
        codigo: map['codigo'],
        esActivo: map['activo'],
        nombre: map['nombre'],
      );
}
