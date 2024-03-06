import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/modulo/modulo_bloc.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';
import 'package:switrans_2_0/src/util/shared/widgets/widgets_shared.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            context.pop();
            ErrorDialog.showDioException(context, state.error!);
          }
          if (state is AuthSuccesState) {
            context.read<ModuloBloc>().add(const ActiveteModuloEvent());
            context.go("/");
          }
          if (state is AuthLoadInProgressState) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.white.withOpacity(0.4),
                content: const SizedBox(
                  height: 260,
                  child: LoadingView(),
                ),
              ),
            );
          }
        },
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: const [
            _DesktopBody(child: AuthView()),
            LinksBar(),
          ],
        ),
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double width = size.width < 780 ? size.width * 0.8 : 500;
    return SizedBox(
      width: size.width,
      height: size.height * 0.95,
      child: Stack(
        children: [
          const CustomBackground(),
          Positioned(
            top: 40,
            child: BuildTitle(size: size),
          ),
          Positioned(
            top: 200,
            left: size.width < 780 ? (size.width - width) / 2 : 80,
            child: Container(
              constraints: const BoxConstraints(minHeight: 460),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff183650).withOpacity(0.5),
              ),
              width: width,
              height: size.height * 0.2,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CustomTitle(),
                  const SizedBox(height: 20),
                  Expanded(child: child),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8),
        Row(
          children: [
            const SizedBox(width: 80),
            const Text(
              "Switrans 2.0",
              style: TextStyle(fontSize: 36, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Image.asset(
              "assets/empresas/icon-multicompany.png",
              width: 36,
            )
          ],
        ),
        Container(
          color: Colors.white,
          width: size.width,
          height: 1,
        ),
      ],
    );
  }
}
