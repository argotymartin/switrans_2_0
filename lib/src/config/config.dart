import 'package:switrans_2_0/src/config/share_preferences/preferences.dart';

late String kPocketBaseUrl;
late String kBackendBaseUrlERP;
late String kBackendBaseUrlMaestro;

const String configParam = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

void initializeConfig() {
  Preferences.env = configParam;
  // ignore: avoid_print
  print("Configuracion: $configParam");
  switch (configParam) {
    case 'local':
      kPocketBaseUrl = 'http://localhost:8090';
      kBackendBaseUrlERP = 'http://192.168.24.158:8085';
      kBackendBaseUrlMaestro = 'http://192.168.24.158:8084';
      break;
    case 'develop':
      kPocketBaseUrl = 'http://192.168.102.34:8090';
      kBackendBaseUrlERP = 'http://192.168.102.18:10000';
      kBackendBaseUrlMaestro = 'http://192.168.102.18:10000';
      break;
    case 'release':
      kPocketBaseUrl = 'http://192.168.102.21:8090';
      kBackendBaseUrlERP = 'http://192.168.102.18:8082';
      kBackendBaseUrlMaestro = 'http://192.168.102.18:8082';
      break;
  }
}

const String kISPocketBaseUrl = 'http://192.168.102.34:8090';

const double kWidthSidebar = 270;
