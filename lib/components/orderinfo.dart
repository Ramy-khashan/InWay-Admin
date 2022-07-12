import 'package:flutter/material.dart';

class OrderInfoItem extends StatelessWidget {
  final Size size;
  final double fontSize;
  final String head;
  final String item;
  const OrderInfoItem(
      {Key? key,
      required this.item,
      required this.head,
      required this.size,
      this.fontSize = .05})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText(
          "$head : $item",
          style: TextStyle(
              fontSize: size.shortestSide * fontSize,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: size.longestSide * .01,
        ),
      ],
    );
  }
}
