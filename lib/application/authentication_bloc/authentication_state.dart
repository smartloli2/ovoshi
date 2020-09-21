import 'package:equatable/equatable.dart';

// Authentication state
abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

// Initial state
class AuthenticationInitial extends AuthenticationState {}

// Success state
class AuthenticationSuccess extends AuthenticationState {
  /// final FirebaseUser firebaseUser;
  /// AuthenticationSuccess(this.firebaseUser);
  AuthenticationSuccess();

  @override

  /// List<Object> get props => [firebaseUser];
  List<Object> get props => [];
}

// Failure state
class AuthenticationFailure extends AuthenticationState {}
