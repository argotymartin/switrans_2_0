import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class ValidateRoutes {
  static const login = "/sign-in";
  static FutureOr<String?> onValidateAuth(BuildContext context, GoRouterState state) async {
    final moduloBloc = context.read<MenuSidebarBloc>();
    final authBloc = context.read<AuthBloc>();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String stringValue = prefs.getString('token') ?? '';
    final isTokenValid = await authBloc.onValidateToken(stringValue);
    if (isTokenValid) {
      final int lengthModulos = moduloBloc.state.paquetes.length;
      if (lengthModulos < 1) {
        moduloBloc.add(const ActiveteMenuSidebarEvent());
      }
    }
    return isTokenValid ? state.path : login;
  }
}
