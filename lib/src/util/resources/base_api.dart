import 'dart:io' show HttpStatus;

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/resources/data_state.dart';

abstract class BaseApiRepository {
  Future<DataState<dynamic>> getStateOf({required Future<Response<dynamic>> Function() request}) async {
    try {
      final dynamic httpResponse = await request();
      if ((httpResponse.statusCode == HttpStatus.ok || httpResponse.statusCode == HttpStatus.created) && httpResponse.data != null) {
        return DataSuccess<dynamic>(httpResponse.data!);
      } else {
        throw DioException(
          response: httpResponse,
          requestOptions: httpResponse.requestOptions,
        );
      }
    } on DioException catch (error) {
      return DataFailed<dynamic>(error);
    }
  }
}
