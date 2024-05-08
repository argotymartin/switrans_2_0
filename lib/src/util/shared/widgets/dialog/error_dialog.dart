import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_backend_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_backend_dio_strategy.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio_strategy.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio_strategy.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_strategy.dart';

class ErrorDialog {
  static final Map<Type, ErrorStrategy> _errorStrategies = <Type, ErrorStrategy>{
    ErrorGenericDio: ErrorGenericDioStrategy(),
    ErrorPocketbaseDio: ErrorPocketbaseDioStrategy(),
    ErrorBackendDio: ErrorBackendDioStrategy(),
  };

  static void showDioException(BuildContext context, DioException exception) {
    if (exception.response?.data != null) {
      final Response<dynamic> response = exception.response!;
      final dynamic errorType = _getErrorType(response.data);
      final ErrorStrategy? strategy = _errorStrategies[errorType];
      if (strategy != null) {
        final Widget content = strategy.buildErrorWidget(context, response);
        _showErrorDialog(context, content);
      }
    }
  }

  static dynamic _getErrorType(Map<dynamic, dynamic> errorData) {
    if (errorData.containsKey('status') && errorData.containsKey('error')) {
      return ErrorGenericDio;
    } else if (errorData.containsKey('code') && errorData.containsKey('message')) {
      return ErrorPocketbaseDio;
    } else if (errorData.containsKey('success') && errorData.containsKey('data') && errorData.containsKey('error')) {
      return ErrorBackendDio;
    }
  }

  static void _showErrorDialog(BuildContext context, dynamic content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Icons.info_outline_rounded, size: 80, color: Theme.of(context).colorScheme.error),
              Text(
                "Ocurrio un error".toUpperCase(),
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
              ),
              const SizedBox(height: 16),
              content,
            ],
          ),
        ),
        actions: <Widget>[
          FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
        ],
      ),
    );
  }
}
