import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class FontCache {
  static final Map<String, pw.Font> _cache = <String, pw.Font>{};

  static Future<pw.Font> getFont(String fontName) async {
    if (_cache.containsKey(fontName)) {
      return _cache[fontName]!;
    }

    late pw.Font font;
    switch (fontName) {
      case 'poppinsBold':
        font = await PdfGoogleFonts.poppinsBold();
        break;
      case 'poppinsRegular':
        font = await PdfGoogleFonts.poppinsRegular();
        break;
      case 'poppinsLight':
        font = await PdfGoogleFonts.poppinsLight();
        break;
      case 'poppinsSemiBold':
        font = await PdfGoogleFonts.poppinsSemiBold();
        break;
      default:
        throw Exception('Font not found');
    }

    _cache[fontName] = font;
    return font;
  }
}
