import 'package:admin/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/button.dart';
import '../../../components/textfield.dart';
import '../controller/sign_in_controller.dart';
import '../controller/sign_in_states.dart';
 
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SignInController(),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: BlocBuilder<SignInController, SignInStates>(
            builder: (context, state) {
              final controller = SignInController.get(context);
              return Form(
                key: controller.validation.formKey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.shortestSide * .04,
                      vertical: size.longestSide * .04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: size.longestSide * .1,
                      ),
                      SizedBox(
                        height: size.longestSide * .2,
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: size.shortestSide * .11,
                                fontFamily: "One"),
                          ),
                        ),
                      ),
                      TextFieldItem(
                        onValid: (val) => controller.validation.email(val),
                        controller: controller.emailController,
                        icon: Icons.email,
                        lable: "Email",
                        size: size,
                      ),
                      TextFieldItem(
                        onValid: (val) => controller.validation.password(val),
                        controller: controller.passwordController,
                        icon: Icons.lock,
                        lable: "Password",
                        size: size,
                        isPassword: true,
                        isScure: controller.isSwitch,
                        onTap: () => controller.visable(),
                      ),
                      SizedBox(
                        height: size.longestSide * .04,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.longestSide * .02,
                          horizontal: size.shortestSide * .07,
                        ),
                        child: controller.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonItem(
                                name: "Sign In",
                                onPressed: () {
                                  if (controller
                                      .validation.formKey.currentState!
                                      .validate()) {
                                    controller.signIn(context);
                                  }
                                },
                              ),
                      ),
                     
                      // Text.rich(
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "Don't have an account?",
                      //         style: TextStyle(
                      //           fontSize: size.shortestSide * .04,
                      //         ),
                      //       ),
                      //       WidgetSpan(
                      //         child: InkWell(
                      //           onTap: () {
                      //             Navigator.pushAndRemoveUntil(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const RegisterScreen()),
                      //                 (route) => false);
                      //           },
                      //           child: Text(
                      //             " Register",
                      //             style: TextStyle(
                      //               fontSize: size.shortestSide * .043,
                      //               fontWeight: FontWeight.w600,
                      //               color: Theme.of(context).primaryColor,
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      /*  Row(
                        children: [
                          IconButton(
                              onPressed: ()async {
                                UserCredential val =await controller.signInWithGoogle();
                                log(val.toString());
                              },
                              icon: const Icon(Icons.access_alarm))
                        ],
                      ) */
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
