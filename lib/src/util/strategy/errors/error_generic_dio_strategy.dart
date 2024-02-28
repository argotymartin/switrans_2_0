import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_strategy.dart';

class ErrorGenericDioStrategy implements ErrorStrategy {
  @override
  Widget buildErrorWidget(BuildContext context, Response response) {
    return _buildErrorDioGeneric(context, response);
  }

  Widget _buildErrorDioGeneric(BuildContext context, Response response) {
    final error = ErrorGenericDio.fromJson(response.data);
    final query = response.requestOptions.queryParameters;
    final metodo = response.requestOptions.method;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildErrorRow("Status", error.status),
        _buildErrorRow("Error", error.error),
        _buildErrorRow("Path", error.path),
        _buildErrorRow("Params", query.toString()),
        _buildErrorRow("Metod", metodo),
      ],
    );
  }

  Widget _buildErrorRow(String label, String value) {
    final style = TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.w500, fontSize: 16);
    return Row(
      children: [
        Text(label, style: style),
        const SizedBox(width: 8),
        Text(value),
      ],
    );
  }
}
