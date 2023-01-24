import 'package:admin/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class ItemShape extends StatelessWidget {
  final Size size;
  final String head;
  final int complete;
  final int notComplete;
  final int length;
  final bool isNeeded;
  final bool isReport;
  const ItemShape(
      {Key? key,
      this.complete = 0,
      this.notComplete = 0,
      required this.head,
      required this.length,
      this.isReport = false,
      required this.size,
      this.isNeeded = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical:
              isNeeded ? size.longestSide * .035 : size.longestSide * .045),
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          vertical: size.longestSide * .01,
          horizontal: size.shortestSide * .05),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                blurRadius: 8, spreadRadius: 5, color: Colors.grey.shade600),
          ],
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
              AppColors.primaryColor.withOpacity(.7),
                Colors.black87
              ])),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(head,
            style: TextStyle(
                color: Colors.white,
                fontSize: size.shortestSide * .07,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: size.longestSide * .03,
        ),
        Text(
          length.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: size.shortestSide * .07,
            fontWeight: FontWeight.bold,
          ),
        ),
        isNeeded
            ? SizedBox(
                height: size.longestSide * .015,
              )
            : const SizedBox.shrink(),
        isNeeded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isReport ? "Not Solved" : "Not Compele",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.shortestSide * .05,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.longestSide * .01,
                        ),
                        Text(
                          notComplete.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.shortestSide * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isReport ? "Solved" : "Compelet",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: size.shortestSide * .05,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: size.longestSide * .01,
                        ),
                        Text(
                          complete.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.shortestSide * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ],
              )
            : const SizedBox.shrink()
      ]),
    );
  }
}
