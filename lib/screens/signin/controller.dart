import 'package:admin/screens/mainhome/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../validation/class.dart';
import 'states.dart';

class SignInController extends Cubit<SignInStates> {
  SignInController() : super(InitialState());
  static SignInController get(context) => BlocProvider.of(context);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isSwitch = true;
  SharedPreferences? preferences;
  final validation = Validation();
  visable() {
    isSwitch = !isSwitch;
    emit(ChangeState());
  }

  onChangeEmail() {
    validation.formKey.currentState!.validate();
    emit(ValidEmailState());
  }

  onChangePassword() {
    validation.formKey.currentState!.validate();
    emit(ValidPasswordState());
  }

  bool isLoading = false;
  signIn(context) {
    isLoading = true;
    emit(CheckSignIn());
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) async {
        await SharedPreferences.getInstance().then((val) {
          val.setString("user_id", value.user!.uid);
          val.setString("auth", "yes");
          isLoading = false;
          emit(DoneSignIn());
          Fluttertoast.showToast(
            msg: "SUCCESS",
          );
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainHomeScreen()),
              (route) => false);
        });
      }).onError<FirebaseAuthException>((error, stackTrace) {
        isLoading = false;
        emit(DoneSignIn());
        Fluttertoast.showToast(
          msg: error.message!,
        );
      });
    } catch (e) {
      isLoading = false;
      emit(DoneSignIn());
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

/* 
Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
} */
}
