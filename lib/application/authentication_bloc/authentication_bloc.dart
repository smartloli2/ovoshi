import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovoshi/application/authentication_bloc/authentication_state.dart';
import 'package:ovoshi/application/authentication_bloc/authentication_event.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';

import 'authentication_state.dart';

// Authentication logic
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  ////
  // User repos
  final UserRepository _userRepository;

  String get token {
    return _userRepository.token;
  }

  String get userId {
    return _userRepository.userId;
  }

  // Constr-r
  AuthenticationBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  // Map event to state
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // Auth started
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    }
    // Logged in
    else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    }
    // Logged out
    else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutInToState();
    }
  }

  // Authentication Started
  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    /// final isSignedIn = await _userRepository.isSignedIn();
    final isSignedIn = await _userRepository.tryAutoLogin();

    // User signed in
    if (isSignedIn) {
      /// final firebaseUser = await _userRepository.getUser();
      yield AuthenticationSuccess();
    }

    // Didn't sign in
    else {
      yield AuthenticationFailure();
    }
  }

  // Authentication LoggedIn
  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess();
  }

  // Authentication LoggedOut
  Stream<AuthenticationState> _mapAuthenticationLoggedOutInToState() async* {
    yield AuthenticationFailure();

    /// _userRepository.signOut();
    _userRepository.logout();
  }
}
