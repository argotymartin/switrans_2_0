import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
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
          const Text("Theme Mode"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ContainerTheme(
                colorPrimary: context.read<ThemeCubit>().state.color!,
                secundaryColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Colors.white,
                themeValueCode: 1,
              ),
              const ContainerTheme(
                colorPrimary: Colors.black54,
                secundaryColor: Colors.grey,
                backgroundColor: Colors.blueGrey,
                themeValueCode: 2,
              ),
              const ContainerTheme(
                colorPrimary: Colors.white,
                secundaryColor: Colors.grey,
                backgroundColor: Colors.white,
                themeValueCode: 3,
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

class ContainerTheme extends StatelessWidget {
  final Color colorPrimary;
  final Color secundaryColor;
  final Color backgroundColor;
  final int themeValueCode;
  const ContainerTheme({
    required this.colorPrimary,
    required this.secundaryColor,
    required this.backgroundColor,
    required this.themeValueCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ThemeCubit>().onChangeThemeMode(themeValueCode);
      },
      child: Container(
        width: 72,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: secundaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: 72,
              height: 8,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: secundaryColor)),
              ),
            ),
            Container(
              width: 14,
              height: 72,
              decoration: BoxDecoration(
                color: colorPrimary,
                border: Border(right: BorderSide(color: secundaryColor)),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  topLeft: Radius.circular(6),
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 8,
              child: SizedBox(
                width: 40,
                height: 30,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List<Widget>.generate(6, (int index) {
                    return Container(
                      margin: const EdgeInsets.all(1),
                      color: Theme.of(context).colorScheme.secondaryFixed,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
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
