import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/functions_postgresql.dart';

class TransaccionContableDB {
  Future<Response<dynamic>> getTransaccionContableDB(TransaccionContableRequest request) async {
    try {
      String where = '';
      final List<String> conditions = <String>[];

      if (request.codigo != null) {
        conditions.add("TTC.TRACON_CODIGO = ${request.codigo!}");
      }
      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("TTC.TRACON_NOMBRE ILIKE '%${request.nombre!}%'");
        }
      }
      if (request.tipoImpuesto != null && request.tipoImpuesto!.isNotEmpty) {
        conditions.add("TTC.TIPIMP_CODIGO = ${request.tipoImpuesto}");
      }
      if (request.isActivo != null) {
        conditions.add("TTC.TRACON_ES_ACTIVO = ${request.isActivo}");
      }
      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }

      final String sql = """
              SELECT TTC.TRACON_CODIGO,
              TTC.TRACON_NOMBRE,
              TTC.TRACON_SIGLA,
              TTC.TRACON_ES_ACTIVO,
              TTC.TRACON_FECHA_CREACION,
              TTC.TRACON_ORDEN,
              U.USUARIO_NOMBRE AS USUARIO,
              CASE WHEN TI.TIPIMP_NOMBRE IS NULL THEN 'SIN TIPO IMPUESTO' ELSE TI.TIPIMP_NOMBRE END AS IMPUESTO
              FROM TB_TRANSACCIONES_CONTABLES TTC
              LEFT JOIN TB_USUARIO U ON U.USUARIO_CODIGO = TTC.USUARIO_CREACION
              LEFT JOIN TB_TIPOIMPUESTO TI ON TI.TIPIMP_CODIGO = TTC.TIPIMP_CODIGO
                $where 
                ORDER BY TTC.TRACON_ORDEN""";
      final Future<Response<dynamic>> response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } on Exception catch (e) {
      debugPrint("Error en getTransaccionContableDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> setTransaccionContableDB(TransaccionContableRequest request) async {
    final String max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_transacciones_contables', key: 'tracon_codigo');
    request.codigo = int.parse(max);
    final String sql = """
      INSERT INTO public.tb_transacciones_contables (
        tracon_codigo, 
        tracon_nombre, 
        tracon_sigla,
        tracon_es_activo,
        usuario_creacion, 
        tipimp_codigo, 
        tracon_fecha_creacion,
        tracon_orden)
        VALUES ($max, 
        '${request.nombre}', 
        '${request.sigla}',
        ${request.isActivo},
        ${request.usuario},
        ${request.tipoImpuesto}, 
        '${DateTime.now()}',
        ${request.secuencia}
        ); """;
    debugPrint("insert SQL:  $sql");
    await FunctionsPostgresql.executeQueryDB(sql);
    final Response<dynamic> resp = await getTransaccionContableDB(request);
    return resp;
  }

  Future<Response<dynamic>> updateTransaccionContableDB(TransaccionContableRequest request) async {
    try {
      final List<String> updateFields = <String>[];

      if (request.nombre != null) {
        updateFields.add("tracon_nombre = '${request.nombre}'");
      }
      if (request.sigla != null) {
        updateFields.add("tracon_sigla = '${request.sigla}'");
      }
      if (request.isActivo != null) {
        updateFields.add("tracon_es_activo = ${request.isActivo}");
      }
      if (request.secuencia != null) {
        updateFields.add("tracon_orden = ${request.secuencia}");
      }
      if (request.tipoImpuesto != null) {
        final Response<dynamic> tipoImpuesto = await getTipoImpuestoCodigoDB(request.tipoImpuesto!);
        updateFields.add("tipimp_codigo = ${tipoImpuesto.data[0]['tipimp_codigo']}");
        request.tipoImpuesto = '${tipoImpuesto.data[0]['tipimp_codigo']}';
      }

      final String updateFieldsStr = updateFields.join(', ');
      final String sql = """
      UPDATE public.tb_transacciones_contables
      SET  $updateFieldsStr
      WHERE tracon_codigo = ${request.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final Response<dynamic> resp = await getTransaccionContableDB(request);
      return resp;
    } on Exception catch (e) {
      debugPrint("Error en updateTransaccionContableDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> getTipoImpuestoDB() async {
    const String sql =
    """ SELECT TIPIMP_CODIGO, TIPIMP_NOMBRE FROM TB_TIPOIMPUESTO ORDER BY TIPIMP_CODIGO """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response<dynamic>> getTipoImpuestoCodigoDB(String tipoImpuestoNombre) async {
    final String sql = """ SELECT TIPIMP_CODIGO from TB_TIPOIMPUESTO WHERE TIPIMP_NOMBRE = '$tipoImpuestoNombre' """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }
}
