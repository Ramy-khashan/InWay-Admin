import 'package:admin/constant.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final Function()? onTap;
  final Size? size;
  final IconData? icon;
  final int index;
  final int selectedIndex;
  final String? head;
  const DrawerItem(
      {Key? key,
      this.head,
      this.icon,
      this.onTap,
      this.size,
      required this.index,
      required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: size!.shortestSide * .03, left: size!.shortestSide * .01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
            colors: index == selectedIndex
                ? [
                    Theme.of(context).primaryColor.withOpacity(.4),
                    Colors.white70,
                  ]
                : [Colors.transparent, Colors.transparent]),
      ),
      child: ListTile(
        leading: Icon(
          icon!,
          color: mainColor1,
          size: size!.shortestSide * .08,
        ),
        title: Text(
          head!,
          style: TextStyle(fontSize: size!.shortestSide * .043),
        ),
        onTap: onTap,
      ),
    );
  }
}
