import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_backend_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_strategy.dart';

class ErrorBackendDioStrategy implements ErrorStrategy {
  @override
  Widget buildErrorWidget(BuildContext context, Response response) {
    return _buildErrorDioGeneric(context, response);
  }

  Widget _buildErrorDioGeneric(BuildContext context, Response response) {
    final error = ErrorBackendDio.fromJson(response.data["error"]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildErrorRow("Error", error.errorClient),
        _buildErrorRow("ErrorTrace", error.errorTrace),
      ],
    );
  }

  Widget _buildErrorRow(String label, String value) {
    final style = TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.w500, fontSize: 16);
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: style),
          const SizedBox(width: 8),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}
