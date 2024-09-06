import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';

class AvatarNavbar extends StatelessWidget {
  final double size;
  const AvatarNavbar({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Auth? auth = context.read<AuthBloc>().state.auth;
    return ClipOval(
      child: auth?.usuario.avatar != null
          ? Image.network(auth!.usuario.avatar, width: size, height: size, fit: BoxFit.cover)
          : Lottie.asset('assets/animations/sin_imagen.json', fit: BoxFit.cover),
    );
  }
}
