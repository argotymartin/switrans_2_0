import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ErrorStrategy {
  Widget buildErrorWidget(BuildContext context, Response<dynamic> response);
}
