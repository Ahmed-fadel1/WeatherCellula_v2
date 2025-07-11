import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_cellula/core/bloc/cubits/login_cubit/login_cubit.dart';
import 'package:weather_app_cellula/core/bloc/cubits/login_cubit/login_states.dart';
import 'package:weather_app_cellula/features/auth/auth_service.dart';
import 'package:weather_app_cellula/features/presentation/pages/log_in_view.dart';
import 'package:weather_app_cellula/features/presentation/widgets/Custom_Page_Indicator.dart';
import 'package:weather_app_cellula/features/presentation/widgets/custom_button.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static String routeName = '/signup';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),

              Text(
                "SIGN UP",
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

              SizedBox(height: screenHeight * 0.1),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'FULL NAME',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          ],
                        ),
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

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenHeight * 0.02,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          obscureText: true,
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
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  CustomPageIndicator(currentIndex: 0),
                ],
              ),

              SizedBox(height: screenHeight * 0.02),

              BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is SignUpSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("PLEASE SIGN IN."),
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
                      Navigator.pushNamed(context, LogInView.routeName);
                    });
                  }
                  if (state is SignUpErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("SIGN UP FAILED."),
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
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoadingState) {
                    return CircularProgressIndicator(color: Colors.white);
                  }
                  return CustomButton(
                    text: "NEXT",
                    backgroundcolor: 0xff014BB4,
                    textcolor: 0xffFFFFFF,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).signup(
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
                  Navigator.pushNamed(context, LogInView.routeName);
                },
                child: Text(
                  "HAVE AN ACCOUNT?",
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
    );
  }
}
