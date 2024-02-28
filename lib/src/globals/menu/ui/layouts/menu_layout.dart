import 'package:flutter/material.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class MenuLayout extends StatelessWidget {
  final Widget child;
  const MenuLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedf2f9),
        endDrawer: const CustomEndDrawer(),
        body: Row(
          children: [
            const Sidebar(),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 66,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4, left: 24, top: 4, right: 4),
                      child: child,
                    ),
                  ),
                  const Positioned(top: 0, left: 0, right: 0, bottom: 0, child: Navbar()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.red,
      backgroundColor: Colors.white,
      width: 260,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 50,
                ),
                Text(
                  "Soy un usuario",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Theme Colors"),
              Wrap(
                children: [
                  _BuildCircleColor(color: Colors.red),
                  _BuildCircleColor(color: Colors.yellow),
                  _BuildCircleColor(color: Colors.blue),
                  _BuildCircleColor(color: Colors.green),
                  _BuildCircleColor(color: Colors.orange),
                  _BuildCircleColor(color: Colors.black),
                ],
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('App Version'),
            subtitle: const Text("Version: 0.0.12"),
            onTap: () => print("Hola"),
          ),
          const ListTile(
            leading: Icon(Icons.abc),
            title: Text('App Version'),
            subtitle: Text("Version: 0.0.12"),
          ),
          const ListTile(
            leading: Icon(Icons.abc),
            title: Text('App Version'),
            subtitle: Text("Version: 0.0.12"),
          ),
        ],
      ),
    );
  }
}

class _BuildCircleColor extends StatelessWidget {
  final Color color;
  const _BuildCircleColor({required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        print("Le di tap al color: ${color.value}");
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: CircleAvatar(
          backgroundColor: color,
        ),
      ),
    );
  }
}
