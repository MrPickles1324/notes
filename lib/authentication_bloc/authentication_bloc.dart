import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? Authenticated(user: authenticationRepository.currentUser)
            : Unauthenticated()) {
    _userSubscription = authenticationRepository.user.listen((user) {
      add(UserChanged(user));
    });
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is UserChanged) {
      yield _mapUserChangedToState(event);
    } else if (event is LogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  AuthenticationState _mapUserChangedToState(UserChanged event) {
    return event.user.isNotEmpty
        ? Authenticated(user: event.user)
        : Unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
