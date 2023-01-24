import 'package:admin/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String? name;
  final Function()? onPressed;
  final bool isCall;
  final bool isFilter;
  final Color? color;
  const ButtonItem({
    Key? key,
    this.name,
    this.color,
    this.isCall = false,
    this.isFilter = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isCall
            ? size.shortestSide * .1
            : isFilter
                ? size.shortestSide * .2
                : size.shortestSide * .3,
        height: isCall
            ? size.longestSide * .05
            : isFilter
                ? size.longestSide * .06
                : size.longestSide * .07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Theme.of(context).cardColor,
             AppColors.primaryColor,
             AppColors.primaryColor,
              Theme.of(context).cardColor,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
        child: Center(
          child: isCall
              ? const Icon(
                  Icons.phone,
                  color: Colors.white,
                )
              : Text(
                  "$name",
                  style: TextStyle(
                    fontFamily: "One",
                    color: Colors.white,
                    fontSize: size.shortestSide * 0.05,
                  ),
                ),
        ),
      ),
    );
  }
}
        
        /**ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: ElevatedButton(
        child: 
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: size.longestSide * .03)),
        ),
      ),
    ) */