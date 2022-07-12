import 'package:flutter/material.dart';

import '../constant.dart';

class TextFieldItem extends StatelessWidget {
  const TextFieldItem(
      {this.isPassword = false,
      this.onValid,
      this.isScure,
      this.onTap,
      this.controller,
      this.lines = 1,
      this.icon,
      this.lable,
      this.size,
      this.type = TextInputType.emailAddress,
      Key? key})
      : super(key: key);
  final Size? size;
  final String? lable;
  final IconData? icon;
  final TextEditingController? controller;
  final bool? isScure;
  final bool? isPassword;
  final int? lines;
  final Function()? onTap;
  final Function(dynamic val)? onValid;
  final TextInputType? type;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: size!.longestSide * .03),
      child: TextFormField(
        validator: (value) => onValid!(value),
        controller: controller,
        maxLines: lines,
        keyboardType: type,
        obscureText: isPassword! ? isScure! : false,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          suffixIcon: isPassword!
              ? IconButton(
                  onPressed: onTap,
                  icon: Icon(
                      isScure!
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      color: isScure!
                          ? Colors.grey
                          : Theme.of(context).primaryColor))
              : const SizedBox(),
          prefixIcon: Icon(
            icon,
            color: mainColor1,
          ),
          labelText: lable,
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
