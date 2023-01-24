 
import 'package:admin/core/constant/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/emptyshape.dart';
import '../../../components/orderinfo.dart';
import '../../revieworder/view/review_order_screen.dart';
import '../controller/orders_cubit.dart';
import '../controller/orders_state.dart'; 

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => OrderController(),
      child: BlocBuilder<OrderController, OrderStates>(
        builder: (context, state) {
          final controller = OrderController.get(context);
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.textColor,
              onPressed: () {
                controller.showFilteration(context, size);
              },
              child: const Icon(Icons.filter_list),
            ),
            body: StreamBuilder(
                stream: controller.allOrders
                    ? FirebaseFirestore.instance.collection("order").snapshots()
                    : controller.compeletOrders
                        ? FirebaseFirestore.instance
                            .collection("order")
                            .where("state", isEqualTo: "compelet")
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("order")
                            .where("state", isNotEqualTo: "compelet")
                            .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.docs.isEmpty
                        ? EmptyShapeItem(
                            size: size,
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              vertical: size.longestSide * .014,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 6,
                                          spreadRadius: 2,
                                          color: Colors.grey)
                                    ]),
                                margin: EdgeInsets.symmetric(
                                    vertical: size.longestSide * .01,
                                    horizontal: size.shortestSide * .03),
                                padding: EdgeInsets.symmetric(
                                    vertical: size.longestSide * .02,
                                    horizontal: size.shortestSide * .03),
                                child: Column(children: [
                                  SizedBox(
                                    height: size.longestSide * .01,
                                  ),
                                  Center(
                                    child: OrderInfoItem(
                                        item: snapshot.data!.docs[index]
                                            .get("orderid_num")
                                            .toString(),
                                        size: size,
                                        head: "Order id",
                                        fontSize: .05),
                                  ),
                                  OrderInfoItem(
                                      item: snapshot.data!.docs[index]
                                          .get("name"),
                                      size: size,
                                      head: "Name",
                                      fontSize: .043),
                                  OrderInfoItem(
                                      item: snapshot.data!.docs[index]
                                          .get("phone"),
                                      size: size,
                                      head: "Phone",
                                      fontSize: .043),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      OrderInfoItem(
                                          item: snapshot.data!.docs[index]
                                              .get("date"),
                                          size: size,
                                          head: "Date",
                                          fontSize: .04),
                                      OrderInfoItem(
                                          item: snapshot.data!.docs[index]
                                              .get("time"),
                                          size: size,
                                          head: "Time",
                                          fontSize: .04),
                                    ],
                                  ),
                                  Center(
                                    child: OrderInfoItem(
                                        item: snapshot.data!.docs[index]
                                                    .get("state") ==
                                                "accepted"
                                            ? "Accepted"
                                            : snapshot.data!.docs[index]
                                                        .get("state") ==
                                                    "compelet"
                                                ? "Order Recived"
                                                : snapshot.data!.docs[index]
                                                            .get("state") ==
                                                        "review"
                                                    ? "In Review"
                                                    : "Waiting",
                                        size: size,
                                        head: "State",
                                        fontSize: .043),
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                    thickness: .9,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewOrderScreen(
                                            docId:
                                                snapshot.data!.docs[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Review Order >>",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: size.shortestSide * .05,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ]),
                              );
                            },
                          );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        },
      ),
    );
  }
}
