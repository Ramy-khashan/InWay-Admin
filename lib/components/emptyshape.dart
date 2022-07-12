import 'package:flutter/material.dart';

class EmptyShapeItem extends StatelessWidget {
  final Size? size;
  const EmptyShapeItem({Key? key,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Empty",
        style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: size!.shortestSide * .13,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
