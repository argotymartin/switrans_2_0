import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/modules/login/ui/blocs/usuario/usuario_bloc.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/views/auth_view.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/widgets/custom_background.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/widgets/custom_title.dart';
import 'package:switrans_2_0/src/modules/login/ui/layouts/widgets/links_bar.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        child: BlocListener<UsuarioBloc, UsuarioState>(
            listener: (context, state) {
              if (state is UsuarioErrorState) {
                AwesomeDialog(
                  width: size.width * 0.5,
                  context: context,
                  dialogType: DialogType.error,
                  headerAnimationLoop: true,
                  animType: AnimType.bottomSlide,
                  title: 'Ocurrio un error',
                  desc: state.error!.response!.data.toString(),
                  buttonsTextStyle: const TextStyle(color: Colors.black),
                  showCloseIcon: true,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              }
              if (state is UsuarioSuccesState) {
                context.read<ModuloBloc>().add(const ActiveteModuloEvent());
                context.go("/");
              }
            },
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                size.width > 1000 ? const _DesktopBody(child: AuthView()) : const _MobileBody(child: AuthView()),
                const LinksBar(),
              ],
            )),
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 420,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: CustomBackground(),
          )
        ],
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
    return SizedBox(
      width: size.width,
      height: size.height * 0.95,
      child: Row(
        children: [
          const Expanded(child: CustomBackground()),
          Container(
            width: 600,
            height: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CustomTitle(),
                const SizedBox(height: 50),
                Expanded(
                  child: child,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
