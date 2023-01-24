import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_colors.dart';
import '../../controller/adding_product_cubit.dart';
import '../../controller/adding_product_state.dart';

class SelectCategoryDropListItem extends StatelessWidget {
  final Size size;
  const SelectCategoryDropListItem({Key? key, required this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductController, AddProductState>(
      builder: (context, state) {
        final controller = AddProductController.get(context);
        return Container(
          height: size.longestSide * .06,
          margin: EdgeInsets.symmetric(vertical: size.longestSide * .025),
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            value: controller.selectCat,
            style: TextStyle(
                color: Colors.white, fontSize: size.shortestSide * .05),
            underline: Container(
              height: 2,
              color: Colors.transparent,
            ),
            isExpanded: true,
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              color: Colors.white,
            ),
            elevation: 20,
            dropdownColor: AppColors.textColor,
            borderRadius: BorderRadius.circular(15),
            items: controller.catList.map((String areaList) {
              return DropdownMenuItem(
                value: areaList,
                child: Text(areaList),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.equalValue(newValue);
            },
          ),
          padding: EdgeInsets.symmetric(
              vertical: size.longestSide * .009,
              horizontal: size.shortestSide * .02),
        );
      },
    );
  }
}
