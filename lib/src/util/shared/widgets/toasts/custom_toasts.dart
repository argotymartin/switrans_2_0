import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_backend_dio.dart';
import 'package:switrans_2_0/src/util/strategy/errors/error_pocketbase_dio.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static dynamic _getErrorType(Map<dynamic, dynamic> errorData) {
    if (errorData.containsKey('status') && errorData.containsKey('error')) {
      return errorData.toString();
    } else if (errorData.containsKey('code') && errorData.containsKey('message')) {
      return ErrorPocketbaseDio;
    } else if (errorData.containsKey('success') && errorData.containsKey('data') && errorData.containsKey('error')) {
      return ErrorBackendDio;
    }
  }

  static void showError(BuildContext context, Map<dynamic, dynamic> errorData) {
    final AudioPlayer player = AudioPlayer();
    player.setAsset('assets/sounds/error-126627.mp3');
    player.play();
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
      description: RichText(
        text: TextSpan(text: errorData.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      icon: const Icon(Icons.error, size: 48, color: Colors.red),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 1000),
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
      callbacks: ToastificationCallbacks(
        onAutoCompleteCompleted: (ToastificationItem value) {
          context.go("/");
        },
      ),
    );
  }
}
