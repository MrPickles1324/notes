import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/authentication_bloc/authentication_bloc.dart';
import 'package:notes/ui/pages/home/bloc/home_bloc.dart';

import 'home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        authenticationBloc: context.read<AuthenticationBloc>(),
      ),
      child: const HomeView(),
    );
  }
}
