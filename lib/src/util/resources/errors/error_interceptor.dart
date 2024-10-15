// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/config/routers/app_router.dart';
import 'package:switrans_2_0/src/util/resources/errors/error_response.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

//typedef ErrorHandler = Future<void> Function(BuildContext context, DioException exception);

class DioErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    await _handleError(err);
    handler.next(err);
  }

  Future<void> _handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        await _handleTimeoutError();
        break;
      case DioExceptionType.badResponse:
        await _handleResponseError(error.response!);
        break;
      case DioExceptionType.cancel:
        await _handleCancelledError();

      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        await _handleConectionError(error);
      case DioExceptionType.unknown:
        await _handleDefaultError(error);
        break;
    }
  }

  Future<void> _handleTimeoutError() async {
    AppRouter.router.go("/token-expired");
  }

  Future<void> _handleResponseError(Response<dynamic> response) async {
    final ErrorResponse errorResponse = ErrorResponse.fromResponse(response);
    print(response);
    String message;
    switch (response.statusCode) {
      case 400:
        message = 'Solicitud incorrecta. Por favor, verifique los datos ingresados.';
        break;
      case 401:
        message = 'No autorizado. Por favor, inicie sesión nuevamente.';

        return;
      case 404:
        message = 'Recurso no encontrado. Verifique la URL.';
        break;
      case 500:
        message = 'Error interno del servidor. Inténtelo más tarde.';
        break;
      default:
        message = 'Ocurrió un error';
    }
    errorResponse.title = message;
    CustomToast.showErrorResp(errorResponse);
  }

  Future<void> _handleCancelledError() async {
    AppRouter.router.go("/token-expired");
  }

  Future<void> _handleDefaultError(DioException error) async {
    final ErrorResponse errorResponse = ErrorResponse(title: "Error de Conexion", content: error.error.toString());
    AppRouter.router.go("/error-connection", extra: errorResponse);
  }

  Future<void> _handleConectionError(DioException error) async {
    final String content = "${error.error} \nServer: ${error.requestOptions.uri.authority}";
    final ErrorResponse errorResponse = ErrorResponse(title: "Error de Conexion", content: content);

    //await AppRouter.router.push("/error-connection", extra: errorResponse);
    await AppRouter.router.push("/error-connection", extra: errorResponse);
  }
}
