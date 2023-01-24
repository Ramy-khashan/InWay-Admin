import 'package:admin/components/adminappbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/all_products_cubit.dart';
import '../controller/all_products_state.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => AllProductController()..getCategories(),
      child: Scaffold(
        appBar: appBar(context, "Products", size),
        body: BlocBuilder<AllProductController, AllProductState>(
          builder: (context, state) {
            final controller = AllProductController.get(context);
            return StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("product").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: size.longestSide * .015,
                            horizontal: size.shortestSide * .03),
                        padding: EdgeInsets.symmetric(
                            horizontal: size.shortestSide * .02,
                            vertical: size.longestSide * .012),
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 3,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.7))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: size.longestSide * .12,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]
                                          .get("name")),
                                      Text(snapshot.data!.docs[index]
                                          .get("price")),
                                      Text(snapshot.data!.docs[index]
                                          .get("category")),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.deleteModel(
                                            context: context,
                                            id: snapshot.data!.docs[index].id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade600,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.showEditModel(
                                          category: snapshot.data!.docs[index]
                                              .get("category"),
                                          name: snapshot.data!.docs[index]
                                              .get("name"),
                                          description: snapshot
                                              .data!.docs[index]
                                              .get("description"),
                                          price: snapshot.data!.docs[index]
                                              .get("price"),
                                          context: context,
                                          size: size,
                                          id: snapshot.data!.docs[index].id,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Text(snapshot.data!.docs[index].get("description")),
                          ],
                        ),
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
            );
          },
        ),
      ),
    );
  }
}
