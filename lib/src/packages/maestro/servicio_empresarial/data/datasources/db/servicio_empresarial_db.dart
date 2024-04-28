import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/packages/maestro/servicio_empresarial/domain/entities/request/servicio_empresarial_request.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/functions_postgresql.dart';

class ServicioEmpresarialDB {
  Future<Response> getServicioEmpresarialDB(ServicioEmpresarialRequest request) async {
    try {
      String where = '';
      List conditions = [];
      if (request.codigo != null) {
        conditions.add("seremp_codigo = ${request.codigo!}");
      }

      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("seremp_nombre ILIKE '%${request.nombre!}%'");
        }
      }

      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }
      final sql = """SELECT se.seremp_codigo,
                      se.seremp_nombre,
                      se.seremp_es_activo,
                      se.seremp_fecha_creacion,
                      se.seremp_fecha_modificacion,
                      u.usuario_nombre
                FROM tb_servicio_empresariales se
                LEFT JOIN public.tb_usuario u on u.usuario_codigo = se.usuario_creacion
                $where 
                ORDER BY se.seremp_codigo""";
      final response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } catch (e) {
      debugPrint("Error en getAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response> setServicioEmpresarialDB(ServicioEmpresarialRequest request) async {
    final max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_servicio_empresariales', key: 'seremp_codigo');

    final sql = """INSERT INTO public.tb_servicio_empresariales (seremp_codigo, 
        seremp_nombre, 
        usuario_creacion, 
        seremp_es_activo)
        VALUES ($max, 
        '${request.nombre}', 
        ${request.usuario},
        true); """;
    debugPrint("insert SQL:  $sql");
    await FunctionsPostgresql.executeQueryDB(sql);
    final resp = await getServicioEmpresarialDB(request);
    return resp;
  }

  Future<Response> updateServicioEmpresarialDB(ServicioEmpresarialRequest request) async {
    try {
      final fecha = DateTime.now();
      final updateFields = [];

      if (request.nombre != null) {
        updateFields.add("seremp_nombre = '${request.nombre}'");
      }
      if (request.esActivo != null) {
        updateFields.add("seremp_es_activo = ${request.esActivo}");
      }

      final updateFieldsStr = updateFields.join(', ');
      final sql = """
      UPDATE public.tb_servicio_empresariales
      SET seremp_fecha_modificacion = '$fecha', $updateFieldsStr
      WHERE seremp_codigo = ${request.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final resp = await getServicioEmpresarialDB(request);
      return resp;
    } catch (e) {
      debugPrint("Error en updateAccionDocumentosDB: $e");
      rethrow;
    }
  }
}
