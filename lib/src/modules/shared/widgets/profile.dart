import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Stack(
        children: [
          const Image(
            height: 160,
            image: AssetImage('assets/background_profile.png'),
            fit: BoxFit.fill,
          ),
          Container(
            color: Colors.indigo.withOpacity(0.4),
            height: 160,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //NavbarAvatar(),
                SizedBox(width: 8),
                Column(
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
        ],
      ),
    );
  }
}
