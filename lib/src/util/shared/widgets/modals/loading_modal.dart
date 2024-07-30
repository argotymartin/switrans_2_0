import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/config/themes/app_theme.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class LoadingModal extends StatelessWidget {
  const LoadingModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
      child: Container(
        color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.1),
        width: double.infinity,
        height: double.infinity,
        child: LoadingView(
          colorText: AppTheme.colorTextTheme,
        ),
      ),
    );
  }
}
