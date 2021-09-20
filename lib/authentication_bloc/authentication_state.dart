part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthenticationState {
  const Authenticated({required this.user});

  final User user;

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { user: ${user.toString()} }';
}

class Unauthenticated extends AuthenticationState {}
