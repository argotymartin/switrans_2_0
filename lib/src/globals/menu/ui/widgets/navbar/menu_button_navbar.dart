import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/ui/menu_ui.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class MenuButtonNavar extends StatelessWidget {
  const MenuButtonNavar({super.key});

  @override
  Widget build(BuildContext context) {
    final OverlayPortalController tooltipController = OverlayPortalController();
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        bool isOpenMenu = state.isOpenMenu;
        bool isMinimize = state.isMinimize;
        double positionedLeft = 0;

        if (isOpenMenu) {
          positionedLeft = 16 + kWidthSidebar;
        }
        if (isMinimize) {
          positionedLeft = 16 + 80;
        }
        if (isMinimize && !isOpenMenu) {
          positionedLeft = 16;
        }
        if (!isMinimize && !isOpenMenu) {
          positionedLeft = 16;
        }
        return MouseRegion(
          onHover: (event) => tooltipController.toggle(),
          child: OverlayPortal(
            controller: tooltipController,
            overlayChildBuilder: (BuildContext context) {
              return Positioned(
                top: 12,
                left: positionedLeft,
                child: MouseRegion(
                  onExit: (event) => tooltipController.toggle(),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Column(
                      children: [
                        _BuildButton(
                          icon: Icons.menu_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            context.read<MenuBloc>().add(const ExpandedMenuEvent());
                          },
                          isSelected: !state.isOpenMenu,
                        ),
                        _BuildButton(
                          icon: Icons.menu_open_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            context.read<MenuBloc>().add(const MinimizedMenuEvent());
                          },
                          isSelected: state.isMinimize,
                        ),
                        _BuildButton(
                          icon: Icons.lock_outlined,
                          onPressed: () {
                            tooltipController.hide();
                            context.read<MenuBloc>().add(const BlockedMenuEvent());
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
      onEnter: (event) => setState(() => isHover = true),
      onExit: (event) => setState(() => isHover = false),
      child: Container(
        height: 40,
        width: 54,
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? Colors.black87
              : isHover
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: IconButton(
          color: isHover ? Colors.white : Colors.grey.shade400,
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
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
