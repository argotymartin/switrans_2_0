import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio_strategy.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio_strategy.dart';

class ErrorDialog {
  static final _errorStrategies = {
    ErrorGenericDio: ErrorGenericDioStrategy(),
    ErrorPocketbaseDio: ErrorPocketbaseDioStrategy(),
  };

  static showErrorDioException(BuildContext context, DioException exception) {
    if (exception.response?.data != null) {
      final Response response = exception.response!;
      final errorType = _getErrorType(response.data);
      final strategy = _errorStrategies[errorType];
      if (strategy != null) {
        final content = strategy.buildErrorWidget(context, response);
        _showErrorDialog(context, content);
      }
    }
  }

  static _getErrorType(dynamic errorData) {
    if (errorData is Map) {
      if (errorData.containsKey('status') && errorData.containsKey('error')) {
        return ErrorGenericDio;
      } else if (errorData.containsKey('code') && errorData.containsKey('message')) {
        return ErrorPocketbaseDio;
      }
    }
  }

  static _showErrorDialog(BuildContext context, content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        content: SizedBox(
          height: 260,
          child: Column(
            children: [
              Icon(Icons.info_outline_rounded, size: 80, color: Theme.of(context).colorScheme.error),
              Text(
                "Ocurrio un error".toUpperCase(),
                style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
              ),
              const SizedBox(height: 16),
              content
            ],
          ),
        ),
        actions: [
          FilledButton(onPressed: () => context.pop(), child: const Text("OK")),
        ],
      ),
    );
  }
}
