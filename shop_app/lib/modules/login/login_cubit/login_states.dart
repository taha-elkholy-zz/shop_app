import 'package:shop_app/models/login_model/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangePasswordVisibilityState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  LoginModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
