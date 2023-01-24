import 'package:admin/components/adminappbar.dart';
import 'package:admin/components/emptyshape.dart';
import 'package:admin/components/textfield.dart';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/button.dart';
import '../../../components/orderinfo.dart';
import '../controller/review_order_cubit.dart';
import '../controller/review_order_state.dart';
 
class ReviewOrderScreen extends StatelessWidget {
  final String docId;

  const ReviewOrderScreen({
    Key? key,
    required this.docId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ReviewOrderController(),
      child: Scaffold(
        appBar: appBar(context, "Review Order", size),
        body: BlocBuilder<ReviewOrderController, ReviewOrderState>(
          builder: (context, state) {
            final controller = ReviewOrderController.get(context);
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("order")
                  .doc(docId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        vertical: size.longestSide * .01,
                        horizontal: size.shortestSide * .03),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.longestSide * .01,
                          ),
                          OrderInfoItem(
                            item: snapshot.data!.get("orderid_num").toString(),
                            size: size,
                            head: "Order id",
                          ),
                          OrderInfoItem(
                            item: snapshot.data!.get("name"),
                            size: size,
                            head: "Name",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OrderInfoItem(
                                item: snapshot.data!.get("phone"),
                                size: size,
                                head: "Phone",
                              ),
                              Center(
                                child: ButtonItem(
                                  name: "Call",
                                  isCall: true,
                                  onPressed: () async {
                                    if (await canLaunch('tel:' +
                                        snapshot.data!
                                            .get("phone")
                                            .toString())) {
                                      await launch('tel:' +
                                          snapshot.data!
                                              .get("phone")
                                              .toString());
                                    } else {
                                      throw "Error occured trying to call that number.";
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.longestSide * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OrderInfoItem(
                                item: snapshot.data!.get("date"),
                                size: size,
                                head: "Date",
                                fontSize: .043,
                              ),
                              OrderInfoItem(
                                head: "Time",
                                item: snapshot.data!.get("time"),
                                size: size,
                                fontSize: .043,
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                            height: size.longestSide * .03,
                          ),
                          Text(
                            "Products in order",
                            style: TextStyle(
                                fontSize: size.shortestSide * .05,
                                fontWeight: FontWeight.w500),
                          ),
                          Column(
                            children: List.generate(
                              snapshot.data!.get("products_id").length,
                              (i) => FutureBuilder(
                                future: FirebaseFirestore.instance
                                    .collection("product")
                                    .doc(snapshot.data!.get("products_id")[i])
                                    .get(),
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapShot) {
                                  if (snapShot.hasData) {
                                    return ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          snapShot.data!.get("image"),
                                          fit: BoxFit.fill,
                                          width: size.shortestSide * .2,
                                          height: size.longestSide * .1,
                                        ),
                                      ),
                                      title: Text(snapShot.data!.get("name")),
                                      subtitle: Text("Price" +
                                          snapShot.data!.get("price") +
                                          " LE."),
                                      trailing: Text(
                                          "Quantity : ${snapshot.data!.get("quantitys")[i]}"),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                            height: size.longestSide * .03,
                          ),
                          Center(
                            child: OrderInfoItem(
                                item: snapshot.data!.get("address"),
                                size: size,
                                head: "Address: ",
                                fontSize: .053),
                          ),
                          Center(
                            child: OrderInfoItem(
                                item: (double.parse(
                                            snapshot.data!.get("totalPrice")) +
                                        20)
                                    .toString(),
                                size: size,
                                head: "Total Price",
                                fontSize: .043),
                          ),
                          Center(
                            child: OrderInfoItem(
                                item: snapshot.data!.get("orderType"),
                                size: size,
                                head: "Payment Type",
                                fontSize: .053),
                          ),
                          TextFieldItem(
                              controller: controller.feedbackController,
                              lines: 3,
                              size: size,
                              icon: Icons.description_rounded,
                              lable: "Information about order"),
                          SizedBox(
                            height: size.longestSide * .03,
                          ),
                          Center(
                            child: OrderInfoItem(
                                item: snapshot.data!.get("state") == "accepted"
                                    ? "Accepted"
                                    : snapshot.data!.get("state") == "compelet"
                                        ? "Order Recived"
                                        : snapshot.data!.get("state") ==
                                                "review"
                                            ? "In Review"
                                            : "Waiting",
                                size: size,
                                head: "State",
                                fontSize: .043),
                          ),
                          snapshot.data!.get("state") == "waiting"
                              ? Center(
                                  child: ButtonItem(
                                    name: "In Review",
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("order")
                                          .doc(docId)
                                          .update({
                                        "state": "review",
                                        "feedback": controller
                                                .feedbackController.text.isEmpty
                                            ? controller.feedbackController.text
                                            : "",
                                      }).whenComplete(() {
                                        controller.feedbackController.clear();
                                        controller.emit(ChangeState());
                                      });
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                          snapshot.data!.get("state") == "review"
                              ? Center(
                                  child: ButtonItem(
                                    name: "Accept",
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("order")
                                          .doc(docId)
                                          .update({
                                        "state": "accepted",
                                        "feedback": controller
                                                .feedbackController.text.isEmpty
                                            ? controller.feedbackController.text
                                            : "",
                                      }).whenComplete(() {
                                        controller.feedbackController.clear();
                                        controller.emit(ChangeState());
                                      });
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: size.longestSide * .023,
                          ),
                          snapshot.data!.get("state") == "accepted"
                              ? Center(
                                  child: ButtonItem(
                                    name: "compelet",
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("order")
                                          .doc(docId)
                                          .update({
                                        "state": "compelet",
                                        "feedback": controller
                                                .feedbackController.text.isEmpty
                                            ? controller.feedbackController.text
                                            : "",
                                      }).whenComplete(() {
                                        controller.feedbackController.clear();
                                        controller.emit(ChangeState());
                                      });
                                    },
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ]),
                  );
                } else {
                  return EmptyShapeItem(
                    size: size,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
