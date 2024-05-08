import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/login/ui/layouts/text_form_field_login.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/util/shared/widgets/buttons/custom_outlined_button.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController passController = TextEditingController();
    final TextEditingController userController = TextEditingController();
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormFieldLogin(
                      icon: Icons.person_2_outlined,
                      placeHoder: "Usuario",
                      textController: userController,
                      onFieldSubmitted: (String value) => onFormSubmit(formKey, userController, passController, context),
                      onValidator: onValidateUser,
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldLogin(
                      icon: Icons.lock_outline_rounded,
                      placeHoder: "Contraseña",
                      textController: passController,
                      onFieldSubmitted: (String value) => onFormSubmit(formKey, userController, passController, context),
                      onValidator: onValidatePass,
                      isPassword: true,
                    ),
                    const SizedBox(height: 40),
                    CustomOutlinedButton(
                      color: Colors.white.withOpacity(0.8),
                      onPressed: () => onFormSubmit(formKey, userController, passController, context),
                      text: "Ingresar",
                      colorText: const Color(0xff183650),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? onValidateUser(String? value) {
    final RegExp regExp = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+$');
    if (value == null || value.isEmpty) {
      return "Ingrese su usuario";
    }
    if (!regExp.hasMatch(value)) {
      return "No es un usuario valido (usuario.nombre)";
    }
    return null;
  }

  String? onValidatePass(String? value) {
    if (value == null || value.isEmpty) {
      return "Ingrese su contraseña";
    }
    if (value.length < 6) {
      return "La contraseña debe ser de mas de 6 caracteres";
    }
    return null;
  }

  void onFormSubmit(
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passController,
    BuildContext context,
  ) {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      final UsuarioRequest params = UsuarioRequest(identity: emailController.text, password: passController.text);
      context.read<AuthBloc>().add(LoginAuthEvent(params: params));
    }
  }
}
