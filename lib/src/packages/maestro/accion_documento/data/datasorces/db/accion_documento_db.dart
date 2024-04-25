import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/packages/maestro/accion_documento/domain/entities/request/accion_documento_request.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/functions_postgresql.dart';

class AccionDocumentoDB {
  AccionDocumentoDB();

  Future<Response> getAccionDocumentosDB(AccionDocumentoRequest request) async {
    String where = '';
    if (request.tipoDocumento != null) {
      where = "WHERE d.documento_codigo = ${request.tipoDocumento!}";
    }
    if (request.nombre!.isNotEmpty) {
      where = "WHERE accdoc_nombre ILIKE '%${request.nombre!}%'";
    }

    if (request.codigo != null) {
      where = "WHERE accdoc_codigo = ${request.codigo!}";
    }
    final sql = """SELECT ad.accdoc_codigo,
                    ad.accdoc_nombre,
                    d.documento_nombre,
                    u.usuario_nombre,
                    ad.accdoc_fecha_creacion,
                    ad.accdoc_fecha_modificacion,
                    ad.accdoc_es_naturaleza_inversa,
                    ad.accdoc_es_activo
              FROM tb_accion_documentos ad
                    LEFT JOIN tb_documento d ON d.documento_codigo = ad.documento_codigo
                    LEFT JOIN tb_usuario u ON u.usuario_codigo = ad.usuario_creacion
              $where 
              ORDER BY ad.accdoc_codigo""";
    final response = FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response> getTipoDocumentosDB() async {
    const sql =
        """SELECT documento_codigo, documento_nombre FROM tb_documento WHERE documento_es_contabilizado = TRUE ORDER BY documento_nombre """;
    final response = await FunctionsPostgresql.executeQueryDB(sql);
    return response;
  }

  Future<Response> setAccionDocumentosDB(AccionDocumentoRequest request) async {
    final max = await FunctionsPostgresql.getMaxIdTable(table: 'tb_accion_documentos', key: 'accdoc_codigo');

    final sql = """INSERT INTO public.tb_accion_documentos (accdoc_codigo, 
        accdoc_nombre, 
        documento_codigo, 
        usuario_creacion, 
        accdoc_es_naturaleza_inversa)
        VALUES ($max, 
        '${request.nombre}', 
        ${request.tipoDocumento}, 
        ${request.usuario}, 
        ${request.isNaturalezaInversa} );""";
    await FunctionsPostgresql.executeQueryDB(sql);
    final resp = await getAccionDocumentosDB(request);
    return resp;
  }

  Future<Response> updateAccionDocumentosDB(AccionDocumentoRequest request) async {
    final fecha = DateTime.now();
    String update = "accdoc_fecha_modificacion = '${fecha.toString()}', ";
    if (request.nombre != null) update += "accdoc_nombre = '${request.nombre}', ";
    if (request.tipoDocumento != null) update += "documento_codigo = ${request.tipoDocumento}, ";
    if (request.isActivo != null) update += "accdoc_es_activo = ${request.isActivo}, ";
    if (request.isNaturalezaInversa != null) update += "accdoc_es_naturaleza_inversa = ${request.isNaturalezaInversa} ";

    final sql = """UPDATE public.tb_accion_documentos
          SET $update
        WHERE accdoc_codigo = ${request.codigo};""";
    await FunctionsPostgresql.executeQueryDB(sql);
    final resp = await getAccionDocumentosDB(request);
    return resp;
  }
}
