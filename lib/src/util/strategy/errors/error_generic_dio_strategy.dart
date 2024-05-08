import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_generic_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_strategy.dart';

class ErrorGenericDioStrategy implements ErrorStrategy {
  @override
  Widget buildErrorWidget(BuildContext context, Response<dynamic> response) {
    return _buildErrorDioGeneric(context, response);
  }

  Widget _buildErrorDioGeneric(BuildContext context, Response<dynamic> response) {
    final ErrorGenericDio error = ErrorGenericDio.fromJson(response.data);
    final Map<String, dynamic> query = response.requestOptions.queryParameters;
    final String metodo = response.requestOptions.method;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildErrorRow("Status", error.status),
        _buildErrorRow("Error", error.error),
        _buildErrorRow("Path", error.path),
        _buildErrorRow("Params", query.toString()),
        _buildErrorRow("Metod", metodo),
      ],
    );
  }

  Widget _buildErrorRow(String label, String value) {
    final TextStyle style = TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.w500, fontSize: 16);
    return Row(
      children: <Widget>[
        Text(label, style: style),
        const SizedBox(width: 8),
        Text(value),
      ],
    );
  }
}
