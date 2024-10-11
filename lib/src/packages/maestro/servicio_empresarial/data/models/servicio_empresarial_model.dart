import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/servicio_empresarial.dart';

class ServicioEmpresarialModel extends ServicioEmpresarial {
  ServicioEmpresarialModel({
    required super.codigo,
    required super.nombre,
    required super.usuario,
    required super.isActivo,
    required super.fechaCreacion,
    required super.fechaModificacion,
  });

  factory ServicioEmpresarialModel.fromDB(Map<String, dynamic> data) => ServicioEmpresarialModel(
        codigo: data['seremp_codigo'],
        nombre: data['seremp_nombre'],
        usuario: data['usuario_nombre'],
        isActivo: data['seremp_es_activo'],
        fechaCreacion: data['seremp_fecha_creacion'].toString(),
        fechaModificacion: data['seremp_fecha_modificacion'].toString(),
      );
}
