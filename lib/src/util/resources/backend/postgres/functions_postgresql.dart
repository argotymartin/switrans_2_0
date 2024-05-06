import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/connection_postregsql.dart';

class FunctionsPostgresql {
  static Future<String> getMaxIdTable({required String table, required String key}) async {
    final conn = await ConnectionPostgresql.onConnect();
    final String sql = "SELECT COALESCE(MAX($key), 1) + 1 FROM $table;";
    final result = await conn.execute(sql);
    result.first.first;
    conn.close();
    return result.first.first.toString();
  }

  static Future<Response> executeQueryDB(String sql) async {
    final path = sql.toLowerCase().split("tb_")[1].split(" ")[0].trim();
    final conn = await ConnectionPostgresql.onConnect();
    final result = await conn.execute(sql);

    final List<Map<String, dynamic>> resultMapList = result.map((row) => row.toColumnMap()).toList();

    final response = Response(
      requestOptions: RequestOptions(path: path),
      data: resultMapList,
      statusCode: 200,
    );
    conn.close();
    return response;
  }
}
