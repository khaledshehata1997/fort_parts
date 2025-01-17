import 'package:components/components.dart';

class AuthenticationStates {}

class AuthenticationInitialState extends AuthenticationStates {}

class AuthenticationRefreshState extends AuthenticationStates {}

class LoginState extends AuthenticationStates {
  LoginState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class RegisterState extends AuthenticationStates {
  RegisterState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}
