import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/usuario.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/usuario/usuario_update_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/globals/menu/ui/widgets/navbar/file_container.dart';
import 'package:switrans_2_0/src/util/shared/widgets/toasts/custom_toasts.dart';

class ColorOption {
  final String name;
  final Color color;
  ColorOption(this.name, this.color);
}

class CustomEndDrawerState extends State<CustomEndDrawer> {
  final List<ColorOption> colorOptions = <ColorOption>[
    ColorOption("Amarillo Claro", const Color(0xFFFFF176)),
    ColorOption("Amarillo Medio", const Color(0xFFFDEB3D)),
    ColorOption("Amarillo Medio Oscuro", const Color(0xFFFDD835)),
    ColorOption("Amarillo Oscuro", const Color(0xFFFBC02D)),
    ColorOption("Amarillo Night", const Color(0xFF967B00)),
    ColorOption("Naranja Claro", const Color(0xFFFFE0B2)),
    ColorOption("Naranja Medio", const Color(0xFFFFCC80)),
    ColorOption("Naranja Medio Oscuro", const Color(0xFFFFB74D)),
    ColorOption("Naranja Oscuro", const Color(0xFFFFA726)),
    ColorOption("Naranja Night", const Color(0xFFAB3500)),
    ColorOption("Rojo Claro", const Color(0xFFFFCDD2)),
    ColorOption("Rojo Medio", const Color(0xFFEF9A9A)),
    ColorOption("Rojo Medio Oscuro", const Color(0xFFE57373)),
    ColorOption("Rojo Oscuro", const Color(0xFFEF5350)),
    ColorOption("Rojo Night", const Color(0xFF8C0000)),
    ColorOption("Rosa Claro", const Color(0xFFEEB2FF)),
    ColorOption("Rosa Medio", const Color(0xFFE880FF)),
    ColorOption("Rosa Medio Oscuro", const Color(0xFFDE4DFF)),
    ColorOption("Rosa Oscuro", const Color(0xFFE926FF)),
    ColorOption("Rosa Night", const Color(0xFF5B0067)),
    ColorOption("Morado Claro", const Color(0xFFD1C4E9)),
    ColorOption("Morado Medio", const Color(0xFFB39DDB)),
    ColorOption("Morado Medio Oscuro", const Color(0xFF9575CD)),
    ColorOption("Morado Oscuro", const Color(0xFF7E57C2)),
    ColorOption("Morado Night", const Color(0xFF2C0070)),
    ColorOption("Azul Claro", const Color(0xFFBBDEFB)),
    ColorOption("Azul Medio", const Color(0xFF90CAF9)),
    ColorOption("Azul Medio Oscuro", const Color(0xFF64B5F6)),
    ColorOption("Azul Oscuro", const Color(0xFF42A5F5)),
    ColorOption("Azul Night", const Color(0xFF004A88)),
    ColorOption("Verde Claro", const Color(0xFFC8E6C9)),
    ColorOption("Verde Medio", const Color(0xFFA5D6A7)),
    ColorOption("Verde Medio Oscuro", const Color(0xFF81C784)),
    ColorOption("Verde Oscuro", const Color(0xFF66BB6A)),
    ColorOption("Verde Night", const Color(0xFF008006)),
    ColorOption("Gris Claro", const Color(0xFFD5D5D5)),
    ColorOption("Gris Medio Claro", const Color(0xFFB2B2B2)),
    ColorOption("Gris Medio Oscuro", const Color(0xFF888888)),
    ColorOption("Gris Oscuro", const Color(0xFF646464)),
    ColorOption("Gris Night", const Color(0xFF484848)),
    ColorOption("Verde Oliva", const Color(0xFFA2B077)),
    ColorOption("Turquesa", const Color(0xFF6AB5B4)),
    ColorOption("Azul Gris", const Color(0xFF627CA0)),
  ];

  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final Usuario? usuarioAuth = context.watch<AuthBloc>().state.auth?.usuario;
    return BlocProvider<UsuarioUpdateBloc>(
      create: (BuildContext context) => UsuarioUpdateBloc(injector())..add(const UsuarioInitialEvent()),
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        width: 260,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white)),
              ),
              child: Column(
                children: <Widget>[
                  BlocListener<UsuarioUpdateBloc, UsuarioUpdateState>(
                    listener: (BuildContext context, UsuarioUpdateState state) {
                      if (state.status == UsuarioStatus.success) {
                        context.read<AuthBloc>().add(const RefreshAuthEvent());
                      }
                      if (state.status == UsuarioStatus.exception) {
                        CustomToast.showError(context, state.exception!);
                      }
                    },
                    child: const FileContainer(),
                  ),
                  Text(
                    usuarioAuth!.nombre,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Theme Colors"),
                const SizedBox(height: 8),
                PopupMenuButton<ColorOption>(
                  icon: const Icon(
                    Icons.color_lens_rounded,
                    size: 36,
                  ),
                  tooltip: "Seleccionar color",
                  elevation: 8,
                  popUpAnimationStyle: AnimationStyle(
                    curve: Easing.legacyAccelerate,
                    duration: const Duration(seconds: 1),
                  ),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                    shape: WidgetStateProperty.all<OutlinedBorder>(const StadiumBorder()),
                  ),
                  onSelected: (ColorOption selectedOption) {
                    setState(() {
                      selectedColor = selectedOption.color;
                      context.read<ThemeCubit>().onChangeColorTheme(selectedOption.color);
                    });
                    Navigator.pop(context);
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<ColorOption>>[
                      PopupMenuItem<ColorOption>(
                        mouseCursor: SystemMouseCursors.click,
                        enabled: false,
                        child: SizedBox(
                          width: 200,
                          height: 400,
                          child: GridView.count(
                            crossAxisCount: 5,
                            children: colorOptions.map<Widget>((ColorOption option) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Tooltip(
                                  message: option.name,
                                  child: _BuildCircleColor(
                                    color: option.color,
                                    isSelected: selectedColor == option.color,
                                    onTap: () {
                                      setState(() {
                                        selectedColor = option.color;
                                        context.read<ThemeCubit>().onChangeColorTheme(option.color);
                                      });
                                      Navigator.pop(context);
                                      Future<void>.delayed(const Duration(milliseconds: 1200)).then(( dynamic value) => Scaffold.of(context).closeEndDrawer());
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
            const Divider(),
            const Text("Theme Mode"),
            const SizedBox(height: 8),
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
