import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class AdminHomePageController extends Cubit<AdminState> {
  AdminHomePageController() : super(InitialPageState());
  static AdminHomePageController get(context) => BlocProvider.of(context);
  int? productNumber;
  int? orderNumber;
  int? categoryNumber;
  int? reportsNumber;
  int? specialOrdersNumber;
  int compeletOrder = 0;
  int notCompeletOrder = 0;
  getProductNum() async {
    await FirebaseFirestore.instance
        .collection("product")
        .where("product_owner",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
       
      productNumber = value.docs.length;

      emit(UpdateProductState());
    });
  }

  getCatNum() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) {
      categoryNumber = value.docs.length;
      emit(UpdadteCatState());
    });
  }

  getrepoNum() async {
    await FirebaseFirestore.instance.collection("reports").get().then((value) {
      reportsNumber = value.docs.length;
      emit(UpdadteReportsState());
    });
  }

  getOrderNum() async {
    await FirebaseFirestore.instance.collection("order").get().then((value) {
      orderNumber = value.docs.length;
      for (var element in value.docs) {
        if (element.get("state") == "compelet") {
          compeletOrder++;
        } else {
          notCompeletOrder++;
        }
      }
      emit(UpdadteOrdersState());
    });
  }

  getSpecialOrdersNum() async {
    await FirebaseFirestore.instance
        .collection("specialOrder")
        .get()
        .then((value) {
      specialOrdersNumber = value.docs.length;
      emit(UpdadteSpecialOrdersState());
    });
  }
}
