
import 'package:file_picker/file_picker.dart';

class UsuarioRequest {
   String? id;
   int? codigo;
   PlatformFile? avatar;

   UsuarioRequest({
    this.id,
    this.codigo,
    this.avatar,
  });

  void clean() {
    id = null;
    codigo = null;
    avatar = null;
  }
}
