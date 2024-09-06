import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:postgres/postgres.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/usuario.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showError(BuildContext context, DioException exception) {
    ErrorResponse? error;
    if (exception.response!.data != null) {
      error = CustomToast._getErrorResponse(exception.response!);
    }
    if (kIsWeb) {
      final AudioPlayer player = AudioPlayer();
      player.setAsset('assets/sounds/error-126627.mp3');
      player.play();
    }
    toastification.show(
      context: context,
      dismissDirection: DismissDirection.endToStart,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(milliseconds: 5000),
      title: Text(
        'Ocurrio un Error!',
        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 24),
      ),
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${error!.code}", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
          RichText(
            text: TextSpan(text: error.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          ),
          RichText(
            text: TextSpan(text: error.details, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w300)),
          ),
        ],
      ),
      icon: Icon(Icons.error, size: 48, color: Colors.red.shade400),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 400),
      animationBuilder: (BuildContext context, Animation<double> animation, Alignment alignment, Widget child) {
        const Offset begin = Offset(1.0, 0.0);
        const Offset end = Offset.zero;
        final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);

        final Animation<Offset> slideAnimation = tween.animate(animation);
        return SlideTransition(
          position: slideAnimation,
          child: child,
        );
      },
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static void showErrorLogin(BuildContext context, DioException exception) {
    ErrorResponse? error;
    if (exception.response != null) {
      if (exception.response!.data != null) {
        error = CustomToast._getErrorResponse(exception.response!);
      }
    } else if (exception.message != null) {
      context.go("/error-connection");
      return;
      //error = CustomToast._getErrorMessage(exception.message!);
    }
    if (kIsWeb) {
      final AudioPlayer player = AudioPlayer();
      player.setAsset('assets/sounds/error-126627.mp3');
      player.play();
    }
    toastification.show(
      context: context,
      dismissDirection: DismissDirection.endToStart,
      type: ToastificationType.error,
      autoCloseDuration: const Duration(milliseconds: 7000),
      title: const Text(
        'Ocurrio un Error!',
        style: TextStyle(color: Color(0xffBA1A1A), fontSize: 24),
      ),
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("${error!.code}", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.red)),
          RichText(
            text: TextSpan(
              text: error.title,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          RichText(
            text: TextSpan(
              text: error.details,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
      icon: const Icon(Icons.error, size: 48, color: Colors.red),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
        ),
      ],
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).colorScheme.errorContainer,
    );
  }

  static void showUpdateUserSuccess(BuildContext context, Usuario usuario) {
    if (kIsWeb) {
      final AudioPlayer player = AudioPlayer();
      player.setAsset('assets/sounds/error-8-206492.mp3');
      player.play();
    }
    toastification.show(
      context: context,
      dismissDirection: DismissDirection.startToEnd,
      type: ToastificationType.success,
      autoCloseDuration: const Duration(milliseconds: 5000),
      title: const Center(
        child: Text(
          'Usuario Actualizado!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      description: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: Text("Igresa nuevamente para ver los cambios",
                  textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black))),
        ],
      ),
      icon: const Icon(Icons.check_circle, size: 48, color: Colors.green),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 400),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
        ),
      ],
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
      backgroundColor: Colors.green.shade100,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  static ErrorResponse _getErrorResponse(Response<dynamic> response) {
    final Map<String, dynamic> errorData;
    if (response.data is String) {
      errorData = jsonDecode(response.data);
    } else if (response.data is ServerException) {
      final ServerException serverException = response.data;
      errorData = <String, dynamic>{
        "status": int.parse(serverException.code!),
        "error": serverException.message,
        "path": serverException.detail,
      };
    } else if (response.data is Exception) {
      final Exception data = response.data;
      errorData = <String, dynamic>{
        "status": 500,
        "error": data.toString(),
        "path": "",
      };
    } else {
      errorData = response.data;
    }
    if (errorData.containsKey('status') && errorData.containsKey('error')) {
      return ErrorResponse(code: errorData["status"], title: errorData["error"], details: errorData["path"]);
      // Valdaciones de Pocketbase
    } else if (errorData.containsKey('code') && errorData.containsKey('message')) {
      if (errorData["data"].isNotEmpty) {
        return ErrorResponse(code: errorData["code"], title: errorData["message"], details: errorData["data"].toString());
      } else {
        return ErrorResponse(code: errorData["code"], title: errorData["message"], details: response.realUri.path);
      }
    } else if (errorData.containsKey('success') && errorData.containsKey('data') && errorData.containsKey('error')) {
      return ErrorResponse(code: 500, title: errorData["error"]["errorClient"], details: response.realUri.path);
    } else {
      return ErrorResponse(code: 400, title: "Error no controlado", details: "");
    }
  }

  // static ErrorResponse _getErrorMessage(String message) {
  //   return ErrorResponse(code: 500, title: message, details: "");
  // }
}

class ErrorResponse {
  final int code;
  final String title;
  final String details;
  ErrorResponse({
    required this.code,
    required this.title,
    required this.details,
  });
}
