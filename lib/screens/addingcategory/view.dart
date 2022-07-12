import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/button.dart';
import '../../components/textfield.dart';
import 'controller.dart';
import 'state.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddCategoryController(),
      child: BlocBuilder<AddCategoryController, AddCategoryState>(
          builder: (context, state) {
        final controller = AddCategoryController.get(context);
        return Form(
          key: controller.validation.formKey,
          child: Scaffold(
              body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.longestSide * .01,
                horizontal: size.shortestSide * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldItem(
                  onValid: (val) => controller.validation.category(val),
                  controller: controller.categoryNameController,
                  icon: Icons.backpack_rounded,
                  lable: "Category Name",
                  size: size,
                ),
                SizedBox(
                  height: size.longestSide * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Main Image",
                      style: TextStyle(
                          fontSize: size.shortestSide * .05,
                          fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () {
                        controller.uploadCatImage(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 3,
                                color: Colors.grey,
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade300,
                        ),
                        height: size.longestSide * .22,
                        width: size.shortestSide * .38,
                        child: controller.isStart
                            ? const Center(child: CircularProgressIndicator())
                            : controller.imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      controller.imageFile!,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Icon(
                                    Icons.add,
                                    size: size.shortestSide * .09,
                                    color: Colors.grey.shade700,
                                  ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                controller.load
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ButtonItem(
                        name: "Add Category",
                        onPressed: () {
                          if (controller.validation.formKey.currentState!
                              .validate()) {
                            if (controller.imageFile != null) {
                              controller.addingCat();
                            }
                          }
                        },
                      )
              ],
            ),
          )),
        );
      }),
    );
  }
}
