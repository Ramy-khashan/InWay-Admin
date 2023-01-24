import 'package:admin/screens/addingproduct/view/widgets/select_category_drop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../components/button.dart';
import '../../../components/textfield.dart';
import '../controller/adding_product_cubit.dart';
import '../controller/adding_product_state.dart'; 

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AddProductController()..getCategories(),
      child: BlocBuilder<AddProductController, AddProductState>(
        builder: (context, state) {
          final controller = AddProductController.get(context);
          return Form(
            key: controller.validation.formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.shortestSide * .03),
                      child: Column(
                        children: [
                          TextFieldItem(
                            onValid: (val) => controller.validation.ask(val),
                            controller: controller.productNameController,
                            icon: Icons.backpack_rounded,
                            lable: "Product Name",
                            size: size,
                            type: TextInputType.text,
                          ),
                          TextFieldItem(
                            onValid: (val) => controller.validation.ask(val),
                            controller: controller.productPriceController,
                            icon: Icons.monetization_on_rounded,
                            lable: "Product Price",
                            size: size,
                            type: TextInputType.number,
                          ),
                          TextFieldItem(
                            onValid: (val) => controller.validation.ask(val),
                            controller: controller.productDescriptionController,
                            icon: Icons.description,
                            lable: "Product Description",
                            size: size,
                          ),
                      SelectCategoryDropListItem(size: size),  Row(
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
                                  controller.uploadImage(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 7,
                                          color: Colors.grey,
                                          spreadRadius: 5)
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade300,
                                  ),
                                  height: size.longestSide * .22,
                                  width: size.shortestSide * .4,
                                  child: controller.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : controller.imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                          SizedBox(
                            height: size.longestSide * .025,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Select Product Images",
                                style: TextStyle(
                                    fontSize: size.shortestSide * .05,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  controller.imagesFile = [];
                                  controller.uploadMultiImage();
                                },
                                child: Text(
                                  "Adding",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: size.shortestSide * .05,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.longestSide * .01,
                        ),
                        controller.imagesFile.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: size.longestSide * .22,
                                child: ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                        vertical: size.longestSide * .005,
                                        horizontal: size.shortestSide * .03),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => Container(
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 3,
                                                  color: Colors.grey,
                                                  spreadRadius: 1)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.grey.shade300,
                                          ),
                                          height: size.longestSide * .18,
                                          width: size.shortestSide * .4,
                                          child: controller.isLoadingMulti
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : controller.imagesFile.isNotEmpty
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image.file(
                                                        controller
                                                            .imagesFile[index],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.add,
                                                      size: size.shortestSide *
                                                          .09,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                        ),
                                    separatorBuilder: (context, i) => SizedBox(
                                        width: size.shortestSide * .02),
                                    itemCount: controller.imagesFile.isEmpty
                                        ? 0
                                        : controller.imagesFile.length),
                              )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.isupload
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ButtonItem(
                              name: "Add Category",
                              onPressed: () {
                                if (controller.validation.formKey.currentState!
                                    .validate()) {
                                  if (controller.selectCat !=
                                      "Select Category") {
                                    if (!controller.isDone) {
                                      controller.addingProduct();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Pleas wait upload image.");
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Chosse Category");
                                  }
                                }
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
