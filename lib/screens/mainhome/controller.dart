import 'package:admin/screens/addingcategory/view.dart';
import 'package:admin/screens/addingproduct/view.dart';
import 'package:admin/screens/orders/view.dart';
import 'package:admin/screens/reports/view.dart';
import 'package:admin/screens/specialorder/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home/view.dart';
import 'state.dart';

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
