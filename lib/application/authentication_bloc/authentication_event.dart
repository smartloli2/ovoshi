import 'package:equatable/equatable.dart';

// Auth event
abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Auth started
class AuthenticationStarted extends AuthenticationEvent {}

// Auth logged in
class AuthenticationLoggedIn extends AuthenticationEvent {}

// Auth logged out
class AuthenticationLoggedOut extends AuthenticationEvent {}
