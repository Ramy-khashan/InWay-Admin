import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/emptyshape.dart';
import '../../components/feesback.dart';

class SpecialOrderScreen extends StatelessWidget {
  const SpecialOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("specialOrder").get(),
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
                    itemBuilder: (context, index) {
                      return FeedBackItem(
                        desc: snapshot.data!.docs[index].get("description"),
                        id: snapshot.data!.docs[index]
                            .get("specialorderid_num")
                            .toString(),
                        address: snapshot.data!.docs[index].get("address"),
                        isAddress: true,
                        date: snapshot.data!.docs[index].get("date"),
                        name: snapshot.data!.docs[index].get("full_name"),
                        phone: snapshot.data!.docs[index].get("phone"),
                        title: snapshot.data!.docs[index].get("special_order"),
                        time: snapshot.data!.docs[index].get("time"),
                        feedbackType: "Order",
                        docId: snapshot.data!.docs[index].id,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
