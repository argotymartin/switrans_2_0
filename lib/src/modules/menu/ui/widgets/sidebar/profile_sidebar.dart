import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/modules/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class ProfileSidebar extends StatelessWidget {
  final bool isMenuIcon;
  const ProfileSidebar({super.key, required this.isMenuIcon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
              children: [
                const AvatarNavbar(size: 48),
                isMenuIcon ? const SizedBox() : const SizedBox(width: 8),
                isMenuIcon
                    ? const SizedBox()
                    : const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. Codex Lantem",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Toronto, Canada",
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w100),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
