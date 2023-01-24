 
import 'package:admin/screens/specialorder/view/special_order_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../addingcategory/view/adding_category_screen.dart';
import '../../addingproduct/view/adding_product_screen.dart';
import '../../home/view/home_screen.dart';
import '../../orders/view/orders_screen.dart';
import '../../reports/view/report_screen.dart';
import 'main_home_state.dart';
 
class MainHomeController extends Cubit<MainHomeState> {
  MainHomeController() : super(InitialState());
  static MainHomeController get(context) => BlocProvider.of(context);
  int index = 0;
  List<Widget> pages = [
    const AdminHomePage(),
    const AddCategoryScreen(),
    const AddProductScreen(),
    const OrderScreen(),
    const SpecialOrderScreen(),
    const ReportScreen()
  ];
  String name = "";
  String email = FirebaseAuth.instance.currentUser!.email.toString();

  getOwnData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        name = element.get("username");
      }
      emit(AddingValueState());
    });
  }

  List<String> appBarHeads = [
    "Home",
    "Add Category",
    "Add Product",
    "Order",
    "Special Order",
    "Reports"
  ];
  void equalIndex(int val, context) {
    index = val;
    emit(ChangePageState());
    Navigator.pop(context);
  }
}
