import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class ProfileSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const ProfileSidebar({
    required this.isMenuIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          height: isMenuIcon ? 94 : 152,
          width: kWidthSidebar,
          image: const AssetImage('assets/cos_home.jpg'),
          fit: BoxFit.cover,
        ),
        Container(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          height: isMenuIcon ? 94 : 152,
        ),
        Center(
          child: Padding(
            padding: isMenuIcon ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(top: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const AvatarNavbar(size: 48),
                isMenuIcon ? const SizedBox() : const SizedBox(width: 8),
                isMenuIcon
                    ? const SizedBox()
                    : BlocBuilder<AuthBloc, AuthState>(
                        builder: (BuildContext context, AuthState state) {
                          if (state is AuthSuccesState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  state.auth!.usuario.nombre,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  state.auth!.usuario.telefonoContacto,
                                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w100),
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
