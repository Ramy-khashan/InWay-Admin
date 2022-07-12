import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/adminshpe.dart';
import 'controller.dart';
import 'state.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AdminHomePageController()
        ..getOrderNum()
        ..getCatNum()
        ..getProductNum()
        ..getSpecialOrdersNum()
        ..getrepoNum(),
      child: Scaffold(
      
        body: BlocBuilder<AdminHomePageController, AdminState>(
          builder: (context, state) {
            final controller = AdminHomePageController.get(context);
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: size.longestSide * .01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemShape(
                    head: "Number of order",
                    length: controller.orderNumber ?? 0,
                    complete: controller.compeletOrder,
                    notComplete: controller.notCompeletOrder,
                    size: size,
                    isNeeded: true,

                  ),
                  ItemShape(
                    head: "Number of Special Order",
                    length: controller.specialOrdersNumber ?? 0,
                    size: size,
                  ),
                  ItemShape(
                    head: "Number of Reports",
                    length: controller.reportsNumber ?? 0,
                    size: size,
                  ),
                  ItemShape(
                      head: "Number of my Product",
                      length: controller.productNumber ?? 0,
                      size: size),
                  ItemShape(
                      head: "Number of Category",
                      length: controller.categoryNumber ?? 0,
                      size: size),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
