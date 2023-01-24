import 'package:admin/components/button.dart';
import 'package:admin/components/textfield.dart';
  import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/validation/validation.dart';
import 'all_products_state.dart';

 
class AllProductController extends Cubit<AllProductState> {
  AllProductController() : super(InitialState());

  static AllProductController get(ctx) => BlocProvider.of(ctx);
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  String selectCat = "Select Category";
  List<String> catList = ["Select Category"];
  Validation validation = Validation();
  getCategories() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) {
      for (var element in value.docs) {
        catList.add(element.data()["category_name"]);
        emit(AddingCatState());
      }
    });
  }

  deleteModel({context, id}) {
    AwesomeDialog(
      dialogType: DialogType.WARNING,
      context: context,
      body: const Text(
        "Are you sure about delete this product!",
        style: TextStyle(fontFamily: "One", fontWeight: FontWeight.w600),
      ),
      btnCancel: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
      btnOk: TextButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("product")
              .doc(id)
              .delete()
              .whenComplete(() => Navigator.pop(context));
        },
        child: const Text("Delete"),
      ),
    ).show();
  }

  showEditModel(
      {context, required Size size, category, name, description, price,id}) {
    nameController.text = name;
    descriptionController.text = description;
    priceController.text = price;

    selectCat = category;
    showBottomSheet(
        context: context,
        builder: (context) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: size.shortestSide * .02,
                  vertical: size.longestSide * .01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldItem(
                    onValid: (val) => validation.ask(val),
                    controller: nameController,
                    icon: Icons.backpack_rounded,
                    lable: "Product Name",
                    size: size,
                    type: TextInputType.text,
                  ),
                  TextFieldItem(
                    onValid: (val) => validation.phoneNumber(val),
                    controller: priceController,
                    icon: Icons.monetization_on_rounded,
                    lable: "Product Price",
                    size: size,
                    type: TextInputType.number,
                  ),
                  Container(
                    height: size.longestSide * .06,
                    margin: EdgeInsets.only(top: size.longestSide * .02),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      value: selectCat,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.shortestSide * .05),
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
                      dropdownColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15),
                      items: catList.map((String areaList) {
                        return DropdownMenuItem(
                          value: areaList,
                          child: Text(areaList),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectCat = newValue.toString();
                        emit(AddingSelectingState());
                      },
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: size.longestSide * .009,
                        horizontal: size.shortestSide * .02),
                  ),
                  TextFieldItem(
                    onValid: (val) => validation.descrtiption(val),
                    controller: descriptionController,
                    icon: Icons.description,
                    lable: "Product Description",
                    size: size,
                    lines: 3,
                    type: TextInputType.text,
                  ),
                  SizedBox(
                    height: size.longestSide * .1,
                  ),
                  ButtonItem(
                    name: "Update",
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("product")
                          .doc(id)
                          .update({
                        "name": nameController.text,
                        "category": selectCat,
                        "description": descriptionController.text,
                        "price": priceController.text
                      }).whenComplete(
                        () => Navigator.pop(context),
                      );
                    },
                  )
                ],
              ),
            ));
  }
}
