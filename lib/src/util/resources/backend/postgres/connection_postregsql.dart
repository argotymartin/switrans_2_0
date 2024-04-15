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
    return conn;
  }
}
