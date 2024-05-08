import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_strategy.dart';

class ErrorPocketbaseDioStrategy implements ErrorStrategy {
  @override
  Widget buildErrorWidget(BuildContext context, Response<dynamic> response) {
    return _buildErrorPocketbase(context, response);
  }

  Widget _buildErrorPocketbase(BuildContext context, Response<dynamic> response) {
    final ErrorPocketbaseDio error = ErrorPocketbaseDio.fromJson(response.data);
    final dynamic query = response.requestOptions.data;
    final String metodo = response.requestOptions.method;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildErrorRow("Status", error.code),
        _buildErrorRow("Error", error.message),
        _buildErrorRow("Data", error.data),
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
