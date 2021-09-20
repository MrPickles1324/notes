import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/settings_repository.dart';
import 'package:notes/ui/pages/home/view/home_page.dart';

import 'authentication_bloc/authentication_bloc.dart';

class NotesApp extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  NotesApp({required this.authenticationRepository, Key? key})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, child) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => SettingsRepository(),
          ),
          // RepositoryProvider(
          //   create: (context) => LocalNotesRepository(),
          // )
        ],
        child: child!,
      ),
      home: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const HomePage(),
      ),
    );
  }
}
