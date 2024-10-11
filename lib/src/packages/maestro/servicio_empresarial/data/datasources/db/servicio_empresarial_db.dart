import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class ServicioEmpresarialDB {
  Future<Response<dynamic>> getServicioEmpresarialDB(ServicioEmpresarialRequest request) async {
    try {
      String where = '';
      final List<String> conditions = <String>[];
      if (request.codigo != null) {
        conditions.add("seremp_codigo = ${request.codigo!}");
      }

      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("seremp_nombre ILIKE '%${request.nombre!}%'");
        }
      }

      if (request.isActivo != null) {
        conditions.add("seremp_es_activo = ${request.isActivo!}");
      }

      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }
      final String sql = """
              SELECT se.seremp_codigo,
                      se.seremp_nombre,
                      se.seremp_es_activo,
                      se.seremp_fecha_creacion,
                      se.seremp_fecha_modificacion,
                      u.usuario_nombre
                FROM tb_servicio_empresariales se
                LEFT JOIN public.tb_usuario u on u.usuario_codigo = se.usuario_creacion
                $where 
                ORDER BY se.seremp_codigo""";
      final Future<Response<dynamic>> response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } on Exception catch (e) {
      debugPrint("Error en getAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> setServicioEmpresarialDB(ServicioEmpresarialRequest request) async {
    final String max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_servicio_empresariales', key: 'seremp_codigo');

    final String sql = """
        INSERT INTO public.tb_servicio_empresariales (
        seremp_codigo, 
        seremp_nombre, 
        usuario_creacion, 
        seremp_es_activo)
        VALUES ($max, 
        '${request.nombre}', 
        ${request.usuario},
        true); """;
    debugPrint("insert SQL:  $sql");
    await FunctionsPostgresql.executeQueryDB(sql);
    final Response<dynamic> resp = await getServicioEmpresarialDB(request);
    return resp;
  }

  Future<Response<dynamic>> updateServicioEmpresarialDB(EntityUpdate<ServicioEmpresarialRequest> request) async {
    try {
      final DateTime fecha = DateTime.now();
      final List<String> updateFields = <String>[];

      if (request.entity.nombre != null) {
        updateFields.add("seremp_nombre = '${request.entity.nombre}'");
      }
      if (request.entity.isActivo != null) {
        updateFields.add("seremp_es_activo = ${request.entity.isActivo}");
      }

      final String updateFieldsStr = updateFields.join(', ');
      final String sql = """
      UPDATE public.tb_servicio_empresariales
      SET seremp_fecha_modificacion = '$fecha', $updateFieldsStr
      WHERE seremp_codigo = ${request.entity.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final Response<dynamic> resp = await getServicioEmpresarialDB(request.entity);
      return resp;
    } on Exception catch (e) {
      debugPrint("Error en updateAccionDocumentosDB: $e");
      rethrow;
    }
  }
}
