


import 'package:dd/features/login/presentation/manger/cubit/login_and_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/login_and_register_repo.dart';

class LoginAndRegisterCubit extends Cubit<LoginAndRegisterState> {
  LoginAndRegisterCubit(this.loginAndRegisterRepo) : super(LoginInitialState());
  final LoginAndRegisterRepo loginAndRegisterRepo;
  Future<void> registerinFireBase(
    String emailAddress,
    String password,
  ) async {
    emit(RegisterLoadingState());
    var request = await loginAndRegisterRepo.register(emailAddress, password);
    emit(request.fold((failure) => RegisterFailurelState(failure.message),
        (register) => RegisterSuccessState(register)));
  }

  Future<void> logininFireBase(
    String emailAddress,
    String password,
  ) async {
    emit(LoginLoadingState());
    var request = await loginAndRegisterRepo.login(emailAddress, password);
    emit(request.fold((failure) => LoginFailurelState(failure.message),
        (login) => LoginSuccessState(login)));
  }

  bool showPassword = true;
  IconData suffix = Icons.visibility;
   changeShowPassword() {
    showPassword = !showPassword;
    suffix = showPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ChangeShowPasswodState());
  }
}
