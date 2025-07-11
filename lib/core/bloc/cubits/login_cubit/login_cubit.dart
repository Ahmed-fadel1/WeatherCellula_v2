import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/core/bloc/cubits/login_cubit/login_states.dart';
import 'package:weather_app_cellula/features/auth/auth_service.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  final AuthService authService = AuthService();

  void login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      bool success = await authService.login(email, password);
      if (success) {
        emit(LoginSuccessState());
      }
    } catch (e) {
      print(e);
      emit(LoginErrorState());
    }
  }

  void signup(String email, String password) async {
    emit(SignUpLoadingState());
    try {
      bool success = await authService.signUp(email, password);
      if (success) {
        emit(SignUpSuccessState());
      }
    } catch (e) {
      print(e);
      emit(SignUpErrorState());
    }
  }
}
