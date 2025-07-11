import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/core/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:weather_app_cellula/core/bloc/cubits/login_cubit/login_states.dart';
import 'package:weather_app_cellula/features/auth/auth_service.dart';
import 'package:weather_app_cellula/features/presentation/pages/main_weather_view.dart';
import 'package:weather_app_cellula/features/presentation/pages/sign_up_view.dart';
import 'package:weather_app_cellula/features/presentation/widgets/custom_button.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});
  static String routeName = '/login';

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService authService = AuthService();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.2),

                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: screenHeight * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "CREATE AN ACCOUNT TO MAKE SDFSDF",
                  style: TextStyle(fontSize: screenHeight * 0.018),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: screenHeight * 0.15),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Color(0xff232D48),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 10),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.02,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Color(0xff232D48),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),

                    SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget your password?",
                        style: TextStyle(
                          color: Color(0xff091F51),
                          fontSize: screenHeight * 0.017,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.06),

                BlocConsumer<LoginCubit, LoginStates>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("WELCOME TO CELLULA!"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(const Duration(milliseconds: 300), () {
                        Navigator.pushNamed(context, MainWeatherView.routeName);
                      });
                    }
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("LOGIN FAILED!"),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoadingState) {
                      return CircularProgressIndicator(color: Colors.white);
                    }
                    return CustomButton(
                      text: "LOGIN",
                      backgroundcolor: 0xff014BB4,
                      textcolor: 0xffFFFFFF,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),

                SizedBox(height: 5),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpView.routeName);
                  },
                  child: Text(
                    "DON'T HAVE AN ACCOUNT?",
                    style: TextStyle(
                      color: Color(0xff091F51),
                      fontSize: screenHeight * 0.017,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
