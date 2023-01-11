import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classe_crud/classe_crud_bloc.dart';
import 'package:proj/features/classes/presentation/blocs/classes/classes_bloc.dart';
import 'package:proj/features/classes/presentation/pages/classes_page.dart';
import 'package:proj/features/msg/presentation/blocs/msg_crud/msg_crud_bloc.dart';
import 'package:proj/features/msg/presentation/pages/msg_page.dart';
import 'package:proj/global/themes/app_theme.dart';
import 'features/msg/presentation/blocs/msg/msg_bloc.dart';
import 'injection_container.dart' as depInj;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await depInj.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => depInj.sl<ClassesBloc>()..add(GetAllClassesEvent())),
        BlocProvider(create: (_) => depInj.sl<ClasseCrudBloc>()),
      ],
      child: MaterialApp(
        theme: appTheme,
        title: 'classes experiment',
        home: ClassesPage(),
      ),
    );
  }
}
