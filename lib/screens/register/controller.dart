import 'dart:developer';

import 'package:admin/screens/mainhome/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../validation/class.dart';
import 'states.dart';

class RegisterController extends Cubit<RegisterStates> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterController() : super(InitialState());
  static RegisterController get(context) => BlocProvider.of(context);
  bool isSwitch = true;
  Validation validation = Validation();
  change() {
    isSwitch = !isSwitch;
    emit(ChangeSwitchState());
  }

  onChangeValue() {
    validation.formKey.currentState!.validate();
    emit(ValidState());
  }

  bool isLoading = false;
  register(context) async {
    isLoading = true;
    emit(CheckRegister());
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text.trim(),
              password: passwordController.value.text)
          .then((val) {
        FirebaseFirestore.instance.collection("users").add({
          "user_id": val.user!.uid,
          "email": emailController.value.text.trim(),
          "password": passwordController.value.text.trim(),
          "phone": phoneController.value.text.trim(),
          "username": usernameController.value.text.trim(),
        }).then((value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("user_id", val.user!.uid);
          preferences.setString("frist_time", "no");
          preferences.setString("auth", "yes");
          log(value.id);
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.id)
              .update({"id": value.id}).whenComplete(() {
            isLoading = false;
            emit(DoneRegister());
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
          emit(DoneRegister());
          Fluttertoast.showToast(
            msg: error.message!,
          );
        });
      });
    } catch (e) {
      isLoading = false;
      emit(DoneRegister());
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
