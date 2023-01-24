import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button.dart';
import '../../../components/textfield.dart';
 import '../../signin/view/sign_in_screen.dart';
import '../controller/register_cubit.dart';
import '../controller/register_states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterController(),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: BlocBuilder<RegisterController, RegisterStates>(
            builder: (context, state) {
              final controller = RegisterController.get(context);
              return Form(
                key: controller.validation.formKey,
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        vertical: size.longestSide * .01,
                        horizontal: size.shortestSide * .03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: size.longestSide * .08,
                        ),
                        SizedBox(
                          height: size.longestSide * .17,
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: size.shortestSide * .11,
                                  fontFamily: "One"),
                            ),
                          ),
                        ),
                        TextFieldItem(
                          onValid: (val) => controller.validation.userName(val),
                          controller: controller.usernameController,
                          icon: Icons.person,
                          lable: "Username",
                          size: size,
                        ),
                        TextFieldItem(
                          onValid: (val) => controller.validation.email(val),
                          controller: controller.emailController,
                          icon: Icons.email,
                          lable: "Email",
                          size: size,
                        ),
                        TextFieldItem(
                          onValid: (val) =>
                              controller.validation.phoneNumber(val),
                          controller: controller.phoneController,
                          icon: Icons.phone,
                          type: TextInputType.number,
                          lable: "Phone",
                          size: size,
                        ),
                        TextFieldItem(
                          controller: controller.passwordController,
                          onValid: (val) => controller.validation.password(val),
                          icon: Icons.lock,
                          lable: "Password",
                          size: size,
                          isPassword: true,
                          isScure: controller.isSwitch,
                          onTap: () => controller.change(),
                        ),
                        SizedBox(
                          height: size.longestSide * .045,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.longestSide * .015,
                            horizontal: size.shortestSide * .07,
                          ),
                          child: controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ButtonItem(
                                  name: "Register",
                                  onPressed: () {
                                    if (controller
                                        .validation.formKey.currentState!
                                        .validate()) {
                                      controller.register(context);
                                    }
                                  },
                                ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Have account already?",
                                style: TextStyle(
                                  fontSize: size.shortestSide * .04,
                                ),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignInScreen()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    " Sign in",
                                    style: TextStyle(
                                      fontSize: size.shortestSide * .043,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
