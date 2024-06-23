import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAndRegisterState {}

final class LoginInitialState extends LoginAndRegisterState {}

final class LoginLoadingState extends LoginAndRegisterState {}

final class LoginFailurelState extends LoginAndRegisterState {
  final String errMessage;

  LoginFailurelState(this.errMessage);
}

final class LoginSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  LoginSuccessState(this.credential);
}

final class RegisterLoadingState extends LoginAndRegisterState {}

final class RegisterFailurelState extends LoginAndRegisterState {
  final String errMessage;

  RegisterFailurelState(this.errMessage);
}

final class RegisterSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  RegisterSuccessState(this.credential);
}

final class ChangeShowPasswodState extends LoginAndRegisterState {}
