import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class MenuLayout extends StatelessWidget {
  final Widget child;
  const MenuLayout({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xffedf2f9),
        endDrawer: const CustomEndDrawer(),
        body: Row(
          children: <Widget>[
            const Sidebar(),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
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
            ),
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
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white))),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 50,
                ),
                Text(
                  "Soy un usuario",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Theme Colors"),
              Wrap(
                children: <Widget>[
                  _BuildCircleColor(color: Colors.indigo),
                  _BuildCircleColor(color: Colors.teal),
                  _BuildCircleColor(color: Colors.blue),
                  _BuildCircleColor(color: Colors.deepOrange),
                  _BuildCircleColor(color: Colors.orange),
                  _BuildCircleColor(color: Colors.cyan),
                  _BuildCircleColor(color: Colors.purple),
                  _BuildCircleColor(color: Colors.deepPurple),
                  _BuildCircleColor(color: Colors.limeAccent),
                ],
              ),
            ],
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('App Version'),
            subtitle: const Text("Version: 0.0.12"),
            onTap: () {},
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
        context.read<ThemeCubit>().onChangeColorTheme(color);
        context.pop();
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: <Color>[
                color.withOpacity(0.2),
                color,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
