import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/register/register_bloc.dart';
import '../../../core/constants.dart';
import '../../../core/theme.dart';
import '../../widgets/loading.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final registerFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  final RegisterBloc registerBloc = RegisterBloc();

  bool isButtonDisabled = true;
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
            image: AssetImage(Constants.signupImg),
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
              key: registerFormKey,
              onChanged: () {
                setState(() {
                  isButtonDisabled = !registerFormKey.currentState!.validate();
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                      controller: nameController,
                      hintText: "Full name",
                      maxLines: 1,
                      inputType: TextInputType.name,
                      preffix: const Icon(
                        Icons.person_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: emailController,
                      hintText: "Email address",
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
                      controller: contactController,
                      hintText: "Phone number",
                      maxLines: 1,
                      maxLength: 10,
                      inputType: TextInputType.phone,
                      preffix: const Icon(
                        Icons.email_rounded,
                        color: Colors.black,
                        size: 18,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Phone number is required";
                        } else if (!validatePhone(val.trim())) {
                          return "Please enter valid phone number";
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
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                    controller: confirmPassController,
                    hintText: "Confirm password",
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
                      } else if (passwordController.text.trim() != val.trim()) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          BlocListener<RegisterBloc, RegisterState>(
            bloc: registerBloc,
            listener: (context, state) {
              if (state is RegisterLoading) {
                Loading.showLoading(context);
              } else if (state is RegisterSuccessfully) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (Route<dynamic> route) => false);
                Loading.showSnackBar(context, "Registered successfully");
              } else if (state is RegisterError) {
                Navigator.pop(context);
                Loading.showSnackBar(
                    context, state.exception.message ?? "Something went wrong");
              }
            },
            child: MyElevatedButton(
                onPress: isButtonDisabled
                    ? null
                    : () {
                        registerBloc.add(RegisterWithEmailAndPass(
                            email: emailController.text.trim(),
                            pass: passwordController.text.trim(),
                            contact: contactController.text.trim(),
                            name: nameController.text.trim()));
                      },
                elevation: 0,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  "Register",
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
                    text: "Have an accout? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                      text: 'Login',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorTheme.primaryColor,
                          fontWeight: FontWeight.w500),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
