import 'package:flutter/material.dart';
import 'package:switrans_2_0/injector.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/menu/menu_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/blocs/modulo/modulo_bloc.dart';
import 'package:switrans_2_0/src/modules/menu/presentation/layouts/menu_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MenuBloc>(create: (_) => MenuBloc()),
        BlocProvider<ModuloBloc>(create: (_) => injector()..add((GetModuloEvent()))),
      ],
      child: const MaterialApp(
          title: 'Switrans 2.0',
          debugShowCheckedModeBanner: false,
          home: MenuLayout(
            child: Icon(IconData(0xe03a, fontFamily: 'MaterialIcons')),
          )),
    );
  }
}
