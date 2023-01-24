import 'package:admin/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context, String head, Size size) {
  return AppBar(
    centerTitle: true,
    title: Text(
      head,
      style: TextStyle(fontFamily: "One", fontSize: size.shortestSide * .08),
    ),
    toolbarHeight: size.longestSide * .085,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, AppColors.primaryColor],
        ),
      ),
    ),
  );
}
