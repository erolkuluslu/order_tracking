import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracking/bloc/auth_bloc.dart';
// import 'package:order_tracking/core/widgets/social_buttons.dart';

import '../core/widgets/gradient_button.dart';
import '../core/widgets/login_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  print('BlocListener: AuthFailure state received');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                } else if (state is AuthSuccess) {
                  print('BlocListener: AuthSuccess state received');
                  // Navigate to the next screen or perform another action
                }
              },
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/signin_balls.png'),
                      const Text(
                        'Sign in.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(height: 50),
                      /*
                      const SocialButton(
                          iconPath: 'assets/svgs/g_logo.svg',
                          label: 'Continue with Google'),
                      const SizedBox(height: 20),
                      const SocialButton(
                        iconPath: 'assets/svgs/f_logo.svg',
                        label: 'Continue with Facebook',
                        horizontalPadding: 90,
                      ),
                      const SizedBox(height: 15),
                      */
                      const Text(
                        'or',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 15),
                      LoginField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 15),
                      LoginField(
                        hintText: 'Password',
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),
                      GradientButton(
                        onPressed: () {
                          print('Login Button Pressed');
                          context.read<AuthBloc>().add(AuthLoginRequested(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ));
                        },
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitial) {
                            print('AuthState: AuthInitial');
                          } else if (state is AuthSuccess) {
                            print('AuthState: AuthSuccess');
                          } else if (state is AuthFailure) {
                            print('AuthState: AuthFailure - ${state.error}');
                          }
                          return Container(); // Replace with your actual UI
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
