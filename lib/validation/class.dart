import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

class Validation {
  var formKey = GlobalKey<FormState>();
  String? email(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Email';
    } else if (!value.isEmail()) {
      val = 'Enter Yout Email Correct';
    }
    return val;
  }

  String? ask(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Order';
    }
    return val;
  }String? repportTitle(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Report title';
    }
    return val;
  }

  String? category(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Category Name';
    }
    return val;
  }
  String? descrtiption(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Descrtiption';
    }
    return val;
  }

  String? password(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Password';
    } else if (!value.isPasswordNormal1()) {
      val = 'Enter Yout Password Correct';
    }
    return val;
  }

  String? phoneNumber(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Phone';
    } else if (!value.isPhone()) {
      val = 'Enter Yout Phone Correct';
    }
    return val;
  }

  String? userName(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Username';
    }
    return val;
  }
}
