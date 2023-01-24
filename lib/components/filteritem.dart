import 'package:flutter/material.dart';

import 'button.dart';

class FilterItem extends StatelessWidget {
  final Size size;
  final String head;
  final Function() onTap;

  const FilterItem(
      {Key? key, required this.head, required this.onTap, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          head,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        ButtonItem(
          isFilter: true,
          onPressed: onTap,
          name: "show",
        )
      ],
    );
  }
}
