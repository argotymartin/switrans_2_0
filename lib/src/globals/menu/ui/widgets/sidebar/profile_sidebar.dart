import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/globals/login/ui/login_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

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
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          height: isMenuIcon ? 94 : 152,
        ),
        Center(
          child: Padding(
            padding: isMenuIcon ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(top: 44),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const AvatarNavbar(size: 60),
                  isMenuIcon ? const SizedBox() : const SizedBox(height: 10),
                  isMenuIcon
                      ? const SizedBox.shrink()
                      : BlocBuilder<AuthBloc, AuthState>(
                          builder: (BuildContext context, AuthState state) {
                            if (state.status == AuthStatus.succes) {
                              return SizedBox(
                                child: Text(
                                  state.auth!.usuario.nombre,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
