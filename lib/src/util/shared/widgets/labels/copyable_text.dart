import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const CopyableText(this.text, {super.key, this.style});

  @override
  State<CopyableText> createState() => _CopyableTextState();
}

class _CopyableTextState extends State<CopyableText> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.text));
    _showTooltip(context);
  }

  void _showTooltip(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 10,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 10.0),
          child: Material(
            elevation: 4.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Text(
                '${widget.text}, copiado en el portapapeles',
                style: const TextStyle(color: Colors.black87, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future<void>.delayed(const Duration(seconds: 2), () {
      _removeTooltip();
    });
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(widget.text, style: widget.style),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => _copyToClipboard(context),
            child: const Icon(Icons.copy, size: 20),
          ),
        ],
      ),
    );
  }
}
