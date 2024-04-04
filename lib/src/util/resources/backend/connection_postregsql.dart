import 'package:postgres/postgres.dart';

class ConnectionPostgresql {
  static Future<Connection> onConnect() async {
    final conn = await Connection.open(
      Endpoint(
        host: '192.168.102.23',
        database: 'switrans',
        username: 'admin',
        password: 'lITOMUvb7k',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    final result0 = await conn.execute("select * from tb_usuario");
    List<ResultRow> result = result0.reversed.toList();
    print(result[0]);
    return conn;
  }
}
