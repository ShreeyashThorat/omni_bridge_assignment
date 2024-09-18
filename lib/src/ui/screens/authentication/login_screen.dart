import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_bridge_assignment/src/core/constants.dart';
import 'package:omni_bridge_assignment/src/core/theme.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/my_button.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/my_textfield.dart';

import '../../../blocs/auth/login/login_bloc.dart';
import '../../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  bool isButtonDisabled = true;

  final LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: 15),
        children: [
          const SizedBox(
            height: 20,
          ),
          Image(
            width: size.width * 0.5,
            height: size.width * 0.5,
            fit: BoxFit.contain,
            image: AssetImage(Constants.loginImg),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Welcome Back!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontWeight: FontWeight.w700, letterSpacing: 1),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Please sign in to continue",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorTheme.textColor.withOpacity(0.6),
                letterSpacing: 1,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 25,
          ),
          Form(
              key: loginFormKey,
              onChanged: () {
                setState(() {
                  isButtonDisabled = !loginFormKey.currentState!.validate();
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                      controller: emailController,
                      hintText: "Email Address",
                      maxLines: 1,
                      inputType: TextInputType.emailAddress,
                      preffix: const Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Email address is required";
                        } else if (!validateEmail(val.trim())) {
                          return "Please enter valid email address";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    maxLines: 1,
                    isObscure: true,
                    preffix: const Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 18,
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Password can not be empty";
                      } else if (!validatePassword(val.trim())) {
                        return "Must contain an uppercase letter, a symbol, and a digit.";
                      } else if (val.trim().length < 8) {
                        return "Password must be greater that 8 digit";
                      }
                      return null;
                    },
                  ),
                ],
              )),
          const SizedBox(
            height: 40,
          ),
          BlocListener<LoginBloc, LoginState>(
            bloc: loginBloc,
            listener: (context, state) {
              if (state is LoginLoading) {
                Loading.showLoading(context);
              } else if (state is LoginSuccessfully) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (Route<dynamic> route) => false);
                Loading.showSnackBar(context, "Loggen in successfully");
              } else if (state is LoginError) {
                Navigator.pop(context);
                Loading.showSnackBar(
                    context, state.exception.message ?? "Something went wrong");
              }
            },
            child: MyElevatedButton(
                onPress: isButtonDisabled
                    ? null
                    : () {
                        loginBloc.add(LoginWithEmailAndPass(
                            email: emailController.text.trim(),
                            pass: passwordController.text.trim()));
                      },
                elevation: 0,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "Don't have an accout? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                      text: 'Register',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorTheme.primaryColor,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
