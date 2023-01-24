
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../components/emptyshape.dart';
import '../../../components/feesback.dart';
 
class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
  
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("reports").snapshots(),
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
                        desc: snapshot.data!.docs[index].get("report_desc"),
                        id: snapshot.data!.docs[index]
                            .get("report_num")
                            .toString(),
                        date: snapshot.data!.docs[index].get("date"),
                        name: snapshot.data!.docs[index].get("name"),
                        phone: snapshot.data!.docs[index].get("phone"),
                        title: snapshot.data!.docs[index].get("report_title"),
                        time: snapshot.data!.docs[index].get("time"),
                        feedbackType: "Report",
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
