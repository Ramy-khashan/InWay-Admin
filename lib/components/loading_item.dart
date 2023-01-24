import 'dart:io';

import 'package:admin/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? const CircularProgressIndicator(
            color: AppColors.primaryColor,
          )
        : const CircularProgressIndicator.adaptive();
  }
}
