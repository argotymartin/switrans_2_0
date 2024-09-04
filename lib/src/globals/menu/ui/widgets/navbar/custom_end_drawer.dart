import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';

class ColorOption {
  final String name;
  final Color color;
  ColorOption(this.name, this.color);
}

class CustomEndDrawerState extends State<CustomEndDrawer> {
  final List<ColorOption> colorOptions = <ColorOption>[
    ColorOption("Morado Claro", const Color(0xff886ab5)),
    ColorOption("Rosa", const Color(0xFF754467)),
    ColorOption("Verde Claro", const Color(0xFF617a28)),
    ColorOption("Azul Medio", const Color(0xFF2b4c81)),
    ColorOption("Azul Brillante", const Color(0xFF0f619f)),
    ColorOption("Turquesa", const Color(0xFF6AB5B4)),
    ColorOption("Rosa Oscuro", const Color(0xFFDD5293)),
    ColorOption("Gris", const Color(0xFF868E96)),
    ColorOption("Azul Claro", const Color(0xFF7C91DF)),
    ColorOption("Naranja", const Color(0xFFE59C6C)),
    ColorOption("Verde Oscuro", const Color(0xFF778C85)),
    ColorOption("Verde Oliva", const Color(0xFFA2B077)),
    ColorOption("Morado Oscuro", const Color(0xFF7976B3)),
    ColorOption("Verde Lima", const Color(0xFF55CE5F)),
    ColorOption("Amarillo", const Color(0xFFFBE231)),
    ColorOption("Azul Gris", const Color(0xFF3955bc)),
  ];

  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      width: 260,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white)),
            ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text("Theme Colors"),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List<Widget>.generate(colorOptions.length, (int index) {
                  final ColorOption option = colorOptions[index];
                  return Tooltip(
                    message: option.name,
                    child: _BuildCircleColor(
                      color: option.color,
                      isSelected: selectedColor == option.color,
                      onTap: () {
                        setState(() {
                          selectedColor = option.color;
                          context.read<ThemeCubit>().onChangeColorTheme(option.color);
                        });
                        context.pop();
                      },
                    ),
                  );
                }),
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

class _BuildCircleColor extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _BuildCircleColor({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  _BuildCircleColorState createState() => _BuildCircleColorState();
}

class _BuildCircleColorState extends State<_BuildCircleColor> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: widget.onTap,
      onHover: (bool hovering) {
        setState(() {
          isHovering = hovering;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.all(2),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.isSelected || isHovering ? Colors.black : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
          boxShadow: widget.isSelected || isHovering
              ? <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: <Color>[
              widget.color.withOpacity(0.2),
              widget.color,
            ],
          ),
        ),
        child: widget.isSelected || isHovering
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16,
                ),
              )
            : null,
      ),
    );
  }
}

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});
  @override
  CustomEndDrawerState createState() => CustomEndDrawerState();
}
