abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String message;
  LoginErrorState(this.message);
}

class SignUpLoadingState extends LoginStates {}

class SignUpSuccessState extends LoginStates {}

class SignUpErrorState extends LoginStates {
  final String message;
  SignUpErrorState(this.message);
}
