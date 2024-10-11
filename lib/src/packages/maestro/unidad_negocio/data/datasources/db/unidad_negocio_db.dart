import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:switrans_2_0/src/packages/maestro/unidad_negocio/domain/entities/request/unidad_negocio_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class UnidadNegocioDB {
  Future<Response<dynamic>> getUnidadNegocioDB(UnidadNegocioRequest request) async {
    try {
      String where = '';
      final List<String> conditions = <String>[];

      if (request.codigo != null) {
        conditions.add("tu.unineg_codigo = ${request.codigo!}");
      }
      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("tu.unineg_nombre ILIKE '%${request.nombre!}%'");
        }
      }
      if (request.empresa != null) {
        conditions.add("e.empresa_codigo = ${request.empresa}");
      }
      if (request.isActivo != null) {
        conditions.add("tu.unineg_activo = ${request.isActivo}");
      }
      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }

      final String sql = """
              SELECT TU.UNINEG_CODIGO,
                      TU.UNINEG_NOMBRE,
                      TU.UNINEG_ACTIVO,
                      TU.UNINEG_FECHACREACION,
                      U.USUARIO_NOMBRE AS USUARIO,
                      E.EMPRESA_CODIGO AS EMPRESA
                      FROM TB_UNIDADNEGOCIO TU
                      LEFT JOIN TB_USUARIO U ON U.USUARIO_CODIGO = TU.USUARIO_CODIGO
                      LEFT JOIN TB_EMPRESA E ON E.EMPRESA_CODIGO = TU.EMPRESA_CODIGO
                $where 
                ORDER BY tu.unineg_codigo""";
      final Future<Response<dynamic>> response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } on Exception catch (e) {
      debugPrint("Error en getAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> setUnidadNegocioDB(UnidadNegocioRequest request) async {
    final String max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_unidadnegocio', key: 'unineg_codigo');

    final String sql = """
      INSERT INTO public.tb_unidadnegocio (
        unineg_codigo, 
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
    final Response<dynamic> resp = await getUnidadNegocioDB(request);
    return resp;
  }

  Future<Response<dynamic>> updateUnidadNegocioDB(EntityUpdate<UnidadNegocioRequest> request) async {
    try {
      final List<String> updateFields = <String>[];

      if (request.entity.nombre != null) {
        updateFields.add("unineg_nombre = '${request.entity.nombre}'");
      }
      if (request.entity.isActivo != null) {
        updateFields.add("unineg_activo = ${request.entity.isActivo}");
      }
      if (request.entity.empresa != null) {
        final Response<dynamic> empresa = await getEmpresaCodigoDB(request.entity.empresa!);
        updateFields.add("empresa_codigo = ${empresa.data[0]['empresa_codigo']}");
        request.entity.empresa = empresa.data[0]['empresa_codigo'];
      }

      final String updateFieldsStr = updateFields.join(', ');
      final String sql = """
      UPDATE public.tb_unidadnegocio
      SET  $updateFieldsStr
      WHERE unineg_codigo = ${request.entity.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final Response<dynamic> resp = await getUnidadNegocioDB(request.entity);
      return resp;
    } on Exception catch (e) {
      debugPrint("Error en updateAccionDocumentosDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> getEmpresasDB() async {
    const String sql =
        """SELECT EMPRESA_CODIGO, EMPRESA_NOMBRE FROM TB_EMPRESA WHERE EMPRESA_APLICA_PREFACTURA = TRUE ORDER BY EMPRESA_NOMBRE ASC """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response<dynamic>> getEmpresaCodigoDB(int empresa) async {
    final String sql = """ SELECT EMPRESA_CODIGO FROM TB_EMPRESA WHERE EMPRESA_APLICA_PREFACTURA = TRUE AND EMPRESA_CODIGO = '$empresa' """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }
}
