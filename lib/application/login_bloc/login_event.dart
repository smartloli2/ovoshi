import 'package:equatable/equatable.dart';

// Login event
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// emailChange(email)
class LoginEmailChange extends LoginEvent {
  final String email;

  LoginEmailChange({this.email});

  @override
  List<Object> get props => [email];
}

// passwordChange(password)
class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

// withCredentialPressed(email, password)
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
