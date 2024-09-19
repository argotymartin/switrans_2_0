import 'package:flutter/foundation.dart';

late String kPocketBaseUrl;
late String kBackendBaseUrl;

const String configParam = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

void initializeConfig() {
  debugPrint(configParam);
  switch (configParam) {
    case 'local':
      kPocketBaseUrl = 'http://localhost:8090';
      //erick     192.168.24.163:8084
      //jordan    192.168.24.148:8084
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
