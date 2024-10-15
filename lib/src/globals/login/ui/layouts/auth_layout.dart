import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/shared/views/loading_view.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) async {
          if (state.status == AuthStatus.error) {
            //CustomToast.showErrorLogin(context, state.error!);
            context.pop();
          }
          if (state.status == AuthStatus.succes) {
            context.read<MenuBloc>().add(const ActivateMenuEvent());
            context.go("/");
          }
          if (state.status == AuthStatus.loading) {
            await showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.6),
              builder: (_) => AlertDialog(
                shape: Border.all(color: Colors.transparent, width: 0),
                backgroundColor: Colors.transparent,
                content: const LoadingView(
                  colorText: Colors.white,
                ),
              ),
            );
          }
        },
        child: const SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _DesktopBody(child: AuthView()),
              LinksBar(),
            ],
          ),
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
    final Size size = MediaQuery.of(context).size;
    final double width = size.width < 780 ? size.width * 0.8 : 480;
    return SizedBox(
      width: size.width,
      height: size.height * 0.95,
      child: Stack(
        children: <Widget>[
          const CustomBackground(),
          Positioned(
            top: 40,
            child: FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: BuildTitle(
                size: size,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: size.width < 780 ? (size.width - width) / 2 : 80,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                constraints: const BoxConstraints(minHeight: 460),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff183650).withOpacity(0.5),
                ),
                width: width,
                height: size.height * 0.2,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    const CustomTitle(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTitle extends StatelessWidget {
  const BuildTitle({
    required this.size,
    super.key,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final double width = size.width <= 720 ? 200 : size.width * 0.15;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(width: 8),
        Row(
          children: <Widget>[
            const SizedBox(width: 20),
            SizedBox(
              width: width,
              child: const FittedBox(
                child: const Text(
                  "Switrans 2.0",
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              "assets/empresas/icon-multicompany.png",
              width: 36,
            ),
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
