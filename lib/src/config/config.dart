import 'package:flutter/foundation.dart';

String kPocketBaseUrl = "";
String kBackendBaseUrl = "";

const String configParam = String.fromEnvironment('ENVIRONMENT', defaultValue: 'local');

void initializeConfig() {
  debugPrint(configParam);
  switch (configParam) {
    case 'local':
      kPocketBaseUrl = 'http://localhost:8090';
      kBackendBaseUrl = 'http://192.168.102.18:10000';
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

const String kTokenPocketBase =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDI2MDg3MDEsImlkIjoiMTN1MWRoMDIwZ2tjeDRpIiwidHlwZSI6ImFkbWluIn0.2ReuDrmuSJ_rMFY7wczpQlaGQ4LiXitA4BpcuzDt0qw";

const double kWidthSidebar = 270;
