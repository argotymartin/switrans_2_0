import 'package:flutter/foundation.dart';

late String kPocketBaseUrl;
late String kBackendBaseUrl;

const String configParam = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

void initializeConfig() {
  debugPrint(configParam);
  switch (configParam) {
    case 'local':
      kPocketBaseUrl = 'http://localhost:8090';

      //erick     192.168.24.163:8084 cable
      //jordan    192.168.24.148:8084 cable

      //erick     172.17.106.99:8084 wifi
      //jordan    172.17.106.21:8084 wifi

      kBackendBaseUrl = 'http://192.168.24.148:8084';
      break;
    case 'develop':
      kPocketBaseUrl = 'http://192.168.102.34:8090';
      kBackendBaseUrl = 'http://192.168.102.18:10000';
      break;
    case 'release':
      kPocketBaseUrl = 'http://192.168.102.21:8090';
      kBackendBaseUrl = 'http://192.168.102.18:8082';
      break;
  }
}

const String kISPocketBaseUrl = 'http://192.168.102.34:8090';

const double kWidthSidebar = 270;
