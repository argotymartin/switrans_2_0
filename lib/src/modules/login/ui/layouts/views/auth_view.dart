import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/modules/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/modules/login/ui/blocs/usuario/usuario_bloc.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/buttons/custom_outlined_button.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/buttons/link_text.dart';
import 'package:switrans_2_0/src/modules/shared/widgets/inputs/custom_inputs.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final passController = TextEditingController();
    final emailController = TextEditingController();
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 370),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (value) => emailController.text = value,
                    validator: (value) {
                      RegExp regExp = RegExp(r'^[a-zA-Z]+\.[a-zA-Z]+$');
                      if (value == null || value.isEmpty) return "Ingrese su usuario";
                      if (!regExp.hasMatch(value)) return "No es un usuario valido";
                      return null;
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.authInputDecoration(
                      hintText: "Ingrese su correo",
                      labelText: "Email",
                      icon: Icons.email_outlined,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onChanged: (value) => passController.text = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Ingrese su contraseña";
                      if (value.length < 6) return "La contraseña debe ser de mas de 6 caracteres";
                      return null;
                    },
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: CustomInputs.authInputDecoration(
                      hintText: "******",
                      labelText: "Contraseña",
                      icon: Icons.lock_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomOutlinedButton(
                      onPressed: () async {
                        final isValid = formKey.currentState!.validate();
                        if (isValid) {
                          final params = UsuarioRequest(identity: emailController.text, password: passController.text);
                          context.read<UsuarioBloc>().add(LoginUsuarioEvent(params: params));
                        }
                      },
                      text: "Ingresar"),
                  const SizedBox(height: 20),
                  LinkText(
                    text: "Nueva Cuenta",
                    onPressed: () {
                      // Navigator.pushNamed(context, Flurorouter.registerRoute);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
