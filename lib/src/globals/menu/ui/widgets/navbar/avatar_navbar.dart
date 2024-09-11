import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';

class AvatarNavbar extends StatelessWidget {
  final double size;
  const AvatarNavbar({
    required this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String name = context.read<AuthBloc>().state.auth!.usuario.avatar.split('/').last;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return ClipOval(
          child: state.auth?.usuario.avatar != null && name.contains('.jpg') || name.contains('.png') || name.contains('.gif')
              ? Image.network(state.auth!.usuario.avatar, width: size, height: size, fit: BoxFit.cover)
              : ColoredBox(color: Colors.white, child: Lottie.asset('assets/animations/sin_imagen.json', fit: BoxFit.cover, width: 40)),
        );
      },
    );
  }
}
