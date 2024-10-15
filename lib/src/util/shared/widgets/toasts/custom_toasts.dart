import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:switrans_2_0/src/util/resources/errors/error_response.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showErrorResp(ErrorResponse error) {
    _playErrorSound();
    toastification.show(
      dismissDirection: DismissDirection.endToStart,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(milliseconds: 5000),
      title: Text(
        error.title,
        style: const TextStyle(color: Colors.red, fontSize: 20),
      ),
      description: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(text: error.content, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18)),
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

  static void showError(BuildContext context, DioException exception) {
    ErrorResponse? error;
    if (exception.response!.data != null) {
      error = ErrorResponse.fromResponse(exception.response!);
    }
    _playErrorSound();
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
          RichText(
            text: TextSpan(text: error!.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18)),
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
        error = ErrorResponse.fromResponse(exception.response!);
      }
    } else if (exception.message != null) {
      context.go("/error-connection");
      return;
    }
    _playErrorSound();
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

  static void _playErrorSound() {
    if (kIsWeb) {
      final AudioPlayer player = AudioPlayer();
      player.setAsset('assets/sounds/error-126627.mp3');
      player.play();
    }
  }
}
