import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/ui/pages/login/cubit/login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _emailInput(),
            const Padding(padding: EdgeInsets.all(8)),
            _passwordInput(),
            ElevatedButton(
              onPressed: () =>
                  context.read<LoginCubit>().logInWithCredentials(),
              child: const Text("Log in"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailInput() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) => TextField(
        key: const Key('LoginEmailInput'),
        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'email',
          errorText: state.email.invalid ? 'invalid email' : null,
        ),
      ),
    );
  }

  Widget _passwordInput() {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) => TextField(
        key: const Key('LoginPasswordInput'),
        onChanged: (password) =>
            context.read<LoginCubit>().passwordChanged(password),
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'password',
          errorText: state.password.invalid ? 'invalid password' : null,
        ),
      ),
    );
  }
}
