import 'package:components/components.dart';
import 'package:data_access/data_access.dart';

class AuthenticationStates {}

class AuthenticationInitialState extends AuthenticationStates {}

class AuthenticationRefreshState extends AuthenticationStates {}

class LoginState extends AuthenticationStates {
  LoginState({
    required this.stateStatus,
    this.isRegistered = false,
  });
  final StateStatus stateStatus;
  final bool isRegistered;
}

class RegisterState extends AuthenticationStates {
  RegisterState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class OTPVerificationState extends AuthenticationStates {
  OTPVerificationState({
    required this.stateStatus,
    this.loggedUser,
  });
  final StateStatus stateStatus;
  final LoggedUser? loggedUser;
}

class ResendOTPState extends AuthenticationStates {
  ResendOTPState({
    required this.stateStatus,
  });
  final StateStatus stateStatus;
}

class FetchProfileState extends AuthenticationStates {
  FetchProfileState({
    required this.stateStatus,
    this.user,
  });
  final StateStatus stateStatus;
  final User? user;
}

class UpdateProfileState extends AuthenticationStates {
  UpdateProfileState({
    required this.stateStatus,
    this.user,
  });
  final StateStatus stateStatus;
  final User? user;
}
