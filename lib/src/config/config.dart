late String kPocketBaseUrl;
late String kBackendBaseUrlERP;
late String kBackendBaseUrlMaestro;

const String configParam = String.fromEnvironment('ENV', defaultValue: 'local');

void initializeConfig() {
  // ignore: avoid_print
  print("Configuracion: $configParam");
  switch (configParam) {
    case 'local':
      kPocketBaseUrl = 'http://localhost:8090';
      kBackendBaseUrlERP = 'http://192.168.102.18:10011';
      kBackendBaseUrlMaestro = 'http://192.168.102.18:10000';
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
