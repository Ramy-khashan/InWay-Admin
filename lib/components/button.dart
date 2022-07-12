import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String? name;
  final Function()? onPressed;
  final bool isCall;
  final Color? color;
  const ButtonItem({
    Key? key,
    this.name,
    this.color,
    this.isCall = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: isCall ? size.shortestSide * .1 : size.shortestSide * .3,
        height: isCall ? size.longestSide * .05 : size.longestSide * .07,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              Theme.of(context).cardColor,
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
              Theme.of(context).cardColor,
            ], begin: Alignment.centerLeft,end: Alignment.centerRight)),
        child: Center(
          child: isCall
              ? const Icon(
                  Icons.phone,
                  color: Colors.white,
                )
              : Text(
                  "$name",
                  style: TextStyle(
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