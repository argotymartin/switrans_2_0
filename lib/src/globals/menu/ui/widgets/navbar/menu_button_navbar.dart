import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class MenuButtonNavar extends StatelessWidget {
  const MenuButtonNavar({super.key});

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController tooltipController = OverlayPortalController();
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (BuildContext context, MenuState state) {
        final Size size = MediaQuery.of(context).size;
        final bool isOpenMenu = state.isOpenMenu;
        final bool isMinimize = state.isMinimize;
        final bool isBlocked = state.isBlocked;
        double positionedLeft = 16;

        if (isOpenMenu) {
          positionedLeft = positionedLeft + kWidthSidebar;
        }
        if (isMinimize) {
          positionedLeft = positionedLeft + 80;
        }
        return MouseRegion(
          onHover: (PointerHoverEvent event) => tooltipController.toggle(),
          child: OverlayPortal(
            controller: tooltipController,
            overlayChildBuilder: (BuildContext context) {
              return Positioned(
                top: 12,
                left: positionedLeft,
                child: MouseRegion(
                  onExit: (PointerExitEvent event) => tooltipController.toggle(),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Column(
                      children: <Widget>[
                        _BuildButton(
                          icon: Icons.menu_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            if (size.width > 480) {
                              context.read<MenuBloc>().add(ExpandedMenuEvent(!isOpenMenu));
                            }
                          },
                          isSelected: !state.isOpenMenu,
                        ),
                        _BuildButton(
                          icon: Icons.menu_open_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            context.read<MenuBloc>().add(MinimizedMenuEvent(!isMinimize));
                          },
                          isSelected: state.isMinimize,
                        ),
                        _BuildButton(
                          icon: Icons.lock_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            context.read<MenuBloc>().add(BlockedMenuEvent(!isBlocked));
                          },
                          isSelected: state.isBlocked,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: _BuildButton(
              icon: Icons.menu_outlined,
              onPressed: () {},
              isSelected: !state.isOpenMenu,
            ),
          ),
        );
      },
    );
  }
}

class _BuildButton extends StatefulWidget {
  final IconData icon;
  final bool isSelected;
  final Function onPressed;

  const _BuildButton({required this.icon, required this.onPressed, required this.isSelected});

  @override
  State<_BuildButton> createState() => _BuildButtonState();
}

class _BuildButtonState extends State<_BuildButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (PointerEnterEvent event) => setState(() => isHover = true),
      onExit: (PointerExitEvent event) => setState(() => isHover = false),
      child: Container(
        height: 40,
        width: 54,
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Colors.black87
              : isHover
                  ? Theme.of(context).canvasColor
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: IconButton(
          color: isHover ? Colors.white : Colors.grey.shade400,
          style: ButtonStyle(
            shape: WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          onPressed: () {
            widget.onPressed();
          },
          icon: Icon(widget.icon),
        ),
      ),
    );
  }
}
