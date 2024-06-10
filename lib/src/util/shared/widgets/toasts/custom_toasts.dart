import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  static void showError(BuildContext context, String errorText) {
    final AudioPlayer player = AudioPlayer();
    player.setAsset('assets/sounds/error-126627.mp3');
    player.play();
    toastification.show(
      context: context,
      dismissDirection: DismissDirection.endToStart,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 5),
      title: const Text('Ocurrio un Error!'),
      description: RichText(text: TextSpan(text: errorText, style: const TextStyle(color: Colors.red))),
      alignment: Alignment.topRight,
      direction: TextDirection.ltr,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (BuildContext context, Animation<double> animation, Alignment alignment, Widget child) {
        return FadeTransition(
          opacity: animation,
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
}
