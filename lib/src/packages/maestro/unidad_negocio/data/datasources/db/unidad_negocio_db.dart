import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/functions_postgresql.dart';

class UnidadNegocioDB {
  Future<Response> getUnidadNegocioDB(UnidadNegocioRequest request) async {
    try {
      String where = '';
      List conditions = [];

      if (request.codigo != null) {
        conditions.add("tu.unineg_codigo = ${request.codigo!}");
      }
      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("tu.unineg_nombre ILIKE '%${request.nombre!}%'");
        }
      }
      if (request.empresa != null && request.empresa!.isNotEmpty) {
        conditions.add("e.empresa_codigo = ${request.empresa}");
      }
      if (request.isActivo != null) {
        conditions.add("tu.unineg_activo = ${request.isActivo}");
      }
      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }

      final sql = """SELECT TU.UNINEG_CODIGO,
                      TU.UNINEG_NOMBRE,
                      TU.UNINEG_ACTIVO,
                      TU.UNINEG_FECHACREACION,
                      U.USUARIO_NOMBRE AS USUARIO,
                      E.EMPRESA_NOMBRE AS EMPRESA
                      FROM TB_UNIDADNEGOCIO TU
                      LEFT JOIN TB_USUARIO U ON U.USUARIO_CODIGO = TU.USUARIO_CODIGO
                      LEFT JOIN TB_EMPRESA E ON E.EMPRESA_CODIGO = TU.EMPRESA_CODIGO
                $where 
                ORDER BY tu.unineg_codigo""";
      final response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } catch (e) {
      debugPrint("Error en getAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response> setUnidadNegocioDB(UnidadNegocioRequest request) async {
    final max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_unidadnegocio', key: 'unineg_codigo');

    final sql = """INSERT INTO public.tb_unidadnegocio (unineg_codigo, 
        unineg_nombre, 
        unineg_activo,
        usuario_codigo, 
        empresa_codigo, unineg_fechacreacion)
        VALUES ($max, 
        '${request.nombre}', 
        true,
        ${request.usuario},
        ${request.empresa}, 
        '${DateTime.now()}'
        ); """;
    debugPrint("insert SQL:  $sql");
    await FunctionsPostgresql.executeQueryDB(sql);
    final resp = await getUnidadNegocioDB(request);
    return resp;
  }

  Future<Response> updateUnidadNegocioDB(UnidadNegocioRequest request) async {
    try {
      final fecha = DateTime.now();
      final updateFields = [];

      if (request.nombre != null) {
        updateFields.add("unineg_nombre = '${request.nombre}'");
      }
      if (request.isActivo != null) {
        updateFields.add("unineg_activo = ${request.isActivo}");
      }
      if (request.empresa != null) {
        final empresa =  await getEmpresaCodigoDB(request.empresa!);
        updateFields.add("empresa_codigo = ${empresa.data[0]['empresa_codigo']}");
        request.empresa = '${empresa.data[0]['empresa_codigo']}';
      }

      final updateFieldsStr = updateFields.join(', ');
      final sql = """
      UPDATE public.tb_unidadnegocio
      SET  $updateFieldsStr
      WHERE unineg_codigo = ${request.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final resp = await getUnidadNegocioDB(request);
      return resp;
    } catch (e) {
      debugPrint("Error en updateAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response> getEmpresasDB() async {
    const sql =
    """SELECT EMPRESA_CODIGO, EMPRESA_NOMBRE FROM TB_EMPRESA WHERE EMPRESA_APLICA_PREFACTURA = TRUE ORDER BY EMPRESA_NOMBRE ASC """;
    final response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response> getEmpresaCodigoDB(String empresaNombre) async {
    final sql =
    """ SELECT EMPRESA_CODIGO FROM TB_EMPRESA WHERE EMPRESA_APLICA_PREFACTURA = TRUE AND EMPRESA_NOMBRE = '$empresaNombre' """;
    final response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }
}