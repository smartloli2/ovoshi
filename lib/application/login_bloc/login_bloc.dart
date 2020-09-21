import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ovoshi/application/login_bloc/login_event.dart';
import 'package:ovoshi/application/login_bloc/login_state.dart';
import 'package:ovoshi/infrastructure/repositories/user_repository.dart';
import 'package:ovoshi/domain/utils/validators.dart';

// Login page logic
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // User repos
  final UserRepository _userRepository;

  // Const-or
  LoginBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  // Map event to state
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // EmailChange
    if (event is LoginEmailChange) {
      yield* _mapLoginEmailChangeToState(event.email);
    }
    // PasswordChange
    else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangeToState(event.password);
    }
    // Login with credentials pressed
    else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapLoginEmailChangeToState(String email) async* {
    // Update valid status
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangeToState(String password) async* {
    // Update valid status
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    // Return loading state
    yield LoginState.loading();
    try {
      // Try sign in
      /// await _userRepository.signInWithCredentials(email, password);
      await _userRepository.login(email, password);

      // Sign in success
      yield LoginState.success();
    } catch (_) {
      // Error occurred
      yield LoginState.failure();
    }
  }
}
