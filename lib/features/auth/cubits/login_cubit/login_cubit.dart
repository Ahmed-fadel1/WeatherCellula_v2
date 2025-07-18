import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/features/auth/cubits/login_cubit/login_states.dart';
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
      } else {
        emit(LoginErrorState('Invalid email or password'));
        await Future.delayed(const Duration(seconds: 1));
        emit(LoginInitialState());
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.message ?? 'Something went wrong'));
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginInitialState());
    } catch (e) {
      emit(LoginErrorState(e.toString()));
      await Future.delayed(const Duration(seconds: 1));
      emit(LoginInitialState());
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
      emit(SignUpErrorState(e.toString()));
    }
  }
}
