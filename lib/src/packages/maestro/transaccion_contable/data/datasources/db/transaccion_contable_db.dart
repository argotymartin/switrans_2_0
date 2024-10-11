import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:switrans_2_0/src/packages/maestro/transaccion_contable/domain/entities/request/transaccion_contable_request.dart';
import 'package:switrans_2_0/src/util/resources/resources.dart';

class TransaccionContableDB {
  Future<Response<dynamic>> getTransaccionContableDB(TransaccionContableRequest request) async {
    try {
      String where = '';
      final List<String> conditions = <String>[];

      if (request.codigo != null) {
        conditions.add("tc.tracon_codigo = ${request.codigo!}");
      }
      if (request.nombre != null) {
        if (request.nombre!.isNotEmpty) {
          conditions.add("tc.tracon_nombre ILIKE '%${request.nombre!}%'");
        }
      }
      if (request.tipoImpuesto != null) {
        conditions.add("tc.tipimp_codigo = ${request.tipoImpuesto}");
      }
      if (request.isActivo != null) {
        conditions.add("tc.tracon_es_activo = ${request.isActivo}");
      }
      if (conditions.isNotEmpty) {
        where = "WHERE ${conditions.join(" AND ")}";
      }

      final String sql = """
             SELECT TC.TRACON_CODIGO,
              TC.TRACON_NOMBRE,
              TC.TRACON_SIGLA,
              TC.TRACON_ES_ACTIVO,
              TC.TRACON_FECHA_CREACION,
              TC.TRACON_ORDEN,
              U.USUARIO_NOMBRE AS USUARIO,
              TI.TIPIMP_CODIGO AS IMPUESTO
              FROM TB_TRANSACCIONES_CONTABLES TC
              LEFT JOIN TB_USUARIO U ON U.USUARIO_CODIGO = TC.USUARIO_CREACION
              LEFT JOIN TB_TIPOIMPUESTO TI ON TI.TIPIMP_CODIGO = TC.TIPIMP_CODIGO
                $where 
                ORDER BY TC.TRACON_ORDEN""";
      final Future<Response<dynamic>> response = FunctionsPostgresql.executeQueryDB(sql);
      return response;
    } on Exception catch (e) {
      debugPrint("Error en getTransaccionContableDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> setTransaccionContableDB(TransaccionContableRequest request) async {
    final String max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_transacciones_contables', key: 'tracon_codigo');

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
        true,
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

  Future<Response<dynamic>> updateTransaccionContableDB(EntityUpdate<TransaccionContableRequest> request) async {
    try {
      final List<String> updateFields = <String>[];

      if (request.entity.nombre != null) {
        updateFields.add("tracon_nombre = '${request.entity.nombre}'");
      }
      if (request.entity.isActivo != null) {
        updateFields.add("tracon_es_activo = ${request.entity.isActivo}");
      }
      if (request.entity.tipoImpuesto != null) {
        final Response<dynamic> tipoImpuesto = await getTipoImpuestoCodigoDB(request.entity.tipoImpuesto!);
        updateFields.add("tipimp_codigo = ${tipoImpuesto.data[0]['tipimp_codigo']}");
        request.entity.tipoImpuesto = tipoImpuesto.data[0]['tipimp_codigo'];
      }

      final String updateFieldsStr = updateFields.join(', ');
      final String sql = """
      UPDATE public.tb_transacciones_contables
      SET  $updateFieldsStr
      WHERE tracon_codigo = ${request.entity.codigo};""";

      debugPrint("updateDB SQL:  $sql");
      await FunctionsPostgresql.executeQueryDB(sql);

      final Response<dynamic> resp = await getTransaccionContableDB(request.entity);
      return resp;
    } on Exception catch (e) {
      debugPrint("Error en updateTransaccionContableDB: $e");
      rethrow;
    }
  }

  Future<Response<dynamic>> getTipoImpuestosDB() async {
    const String sql = """SELECT TIPIMP_CODIGO, TIPIMP_NOMBRE FROM TB_TIPOIMPUESTO ORDER BY TIPIMP_NOMBRE ASC """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response<dynamic>> getTipoImpuestoCodigoDB(int tipoImpuesto) async {
    final String sql = """ SELECT TIPIMP_CODIGO FROM TB_TIPOIMPUESTO WHERE TIPIMP_CODIGO = '$tipoImpuesto' """;
    final Response<dynamic> response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }
}
