import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/auth.dart';
import 'package:switrans_2_0/src/globals/login/ui/blocs/auth/auth_bloc.dart';
import 'package:switrans_2_0/src/globals/menu/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/globals/menu/ui/blocs/usuario/usuario_update_bloc.dart';

class FileContainer extends StatefulWidget {
  const FileContainer({super.key});

  @override
  State<FileContainer> createState() => _FileContainerState();
}

class _FileContainerState extends State<FileContainer> {
  late PlatformFile? _file;
  String name = "---";

  Future<dynamic> _pickAndSaveFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: <String>['jpg', 'png', 'gif', 'mp4'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _file = result.files.first;
          name = _file!.name;
          if (name.contains('.jpg') || name.contains('.png') || name.contains('.gif') || name.contains('.mp4')) {
            final Auth? auth = context.read<AuthBloc>().state.auth;
            final UsuarioRequest request = UsuarioRequest(
              id: auth?.usuario.id,
              codigo: auth?.usuario.codigo,
              avatar: _file!,
            );
            context.read<UsuarioUpdateBloc>().add(UpdateUsuarioEvent(request: request));
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                icon: const Icon(
                  Icons.warning,
                  color: Colors.redAccent,
                  size: 100,
                ),
                content: const Text('Solo se permiten imagenes o videos'),
                actions: <Widget>[TextButton(onPressed: () => context.pop(), child: const Text('Ok'))],
              ),
            );
          }
        });
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error al seleccionar el archivo: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Auth? auth = context.read<AuthBloc>().state.auth;
    return CircleAvatar(
      maxRadius: 50,
      child: Stack(
        children: <Widget>[
          name.contains('.jpg') || name.contains('.png') || name.contains('.gif')
              ? kIsWeb
                  ? ClipOval(
                      child: Image.memory(
                        _file!.bytes!,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                        File(_file!.path!),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    )
              : auth?.usuario.avatar != null  && auth!.usuario.avatar.contains('.jpg') || auth!.usuario.avatar.contains('.png') || auth.usuario.avatar.contains('.gif')
                  ? ClipOval(
                      child: Image.network(
                        auth.usuario.avatar,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(child: Lottie.asset('assets/animations/sin_imagen.json', fit: BoxFit.cover)),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white, width: 5),
              ),
              child: FloatingActionButton(
                backgroundColor: Colors.red.withOpacity(0.8),
                elevation: 0,
                onPressed: _pickAndSaveFile,
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
