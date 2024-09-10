import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class ImageCachePdf {
  static final Map<String, pw.MemoryImage> _cache = <String, pw.MemoryImage>{};

  static Future<pw.MemoryImage> getImage(String assetPath) async {
    if (_cache.containsKey(assetPath)) {
      return _cache[assetPath]!;
    }

    final ByteData data = await rootBundle.load(assetPath);
    final pw.MemoryImage image = pw.MemoryImage(data.buffer.asUint8List());
    _cache[assetPath] = image;
    return image;
  }
}
