import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class ValidateRoutes {
  static const String tokenExpired = "/token-expired";
  static FutureOr<String?> onValidateAuth(BuildContext context, GoRouterState state) async {
    final MenuSidebarBloc moduloBloc = context.read<MenuSidebarBloc>();
    final AuthBloc authBloc = context.read<AuthBloc>();

    final bool isTokenValid = await authBloc.onValidateToken();
    if (isTokenValid) {
      final int lengthModulos = moduloBloc.state.paquetes.length;
      if (lengthModulos < 1) {
        moduloBloc.add(const ActiveteMenuSidebarEvent());
      }
    }
    return isTokenValid ? state.path : tokenExpired;
  }
}
