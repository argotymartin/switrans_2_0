import 'package:flutter/material.dart';

class NotificationIndicator extends StatelessWidget {
  const NotificationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.notification_add_outlined, color: Colors.grey),
        Positioned(
          left: 2,
          child: Container(
            width: 5,
            height: 5,
            decoration: bulidBoxDecoration(),
          ),
        )
      ],
    );
  }

  BoxDecoration bulidBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100),
      );
}
