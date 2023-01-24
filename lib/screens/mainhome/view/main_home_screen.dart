import 'package:admin/components/adminappbar.dart';
import 'package:admin/core/constant/app_colors.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/draweritem.dart';
import '../../flashpage/view/splash_screen.dart';
import '../controller/main_home_cubit.dart';
import '../controller/main_home_state.dart';
 

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => MainHomeController()..getOwnData(),
      child: BlocBuilder<MainHomeController, MainHomeState>(
        builder: (context, state) {
          final controller = MainHomeController.get(context);
          return Scaffold(
            appBar:
                appBar(context, controller.appBarHeads[controller.index], size),
            drawer: Drawer(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.longestSide * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: size.shortestSide * .1,
                              child: Icon(
                                Icons.person,
                                size: size.shortestSide * .11,
                                color: Colors.white,
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: size.shortestSide * .03,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  fit: BoxFit.contain,
                                  child: Text(controller.name,
                                      style: const TextStyle(
                                          //  fontSize: size.shortestSide * .055,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600)),
                                ),
                                FittedBox(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  fit: BoxFit.contain,
                                  child: Text(controller.email,
                                      style: const TextStyle(
                                        //  fontSize: size.shortestSide * .038,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.textColor,
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.longestSide * .02,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      DrawerItem(
                        head: "Home",
                        icon: Icons.home_rounded,
                        onTap: () {
                          controller.equalIndex(0, context);
                        },
                        index: controller.index,
                        selectedIndex: 0,
                        size: size,
                      ),
                      DrawerItem(
                        head: "Add Category",
                        icon: Icons.playlist_add_circle_rounded,
                        onTap: () {
                          controller.equalIndex(1, context);
                        },
                        size: size,
                        index: controller.index,
                        selectedIndex: 1,
                      ),
                      DrawerItem(
                        head: "Add Product",
                        icon: Icons.note_add_outlined,
                        onTap: () {
                          controller.equalIndex(2, context);
                        },
                        size: size,
                        index: controller.index,
                        selectedIndex: 2,
                      ),
                      DrawerItem(
                        head: "Orders",
                        icon: Icons.shopping_cart_checkout_rounded,
                        onTap: () {
                          controller.equalIndex(3, context);
                        },
                        size: size,
                        index: controller.index,
                        selectedIndex: 3,
                      ),
                      DrawerItem(
                        head: "Special Order",
                        icon: Icons.token_sharp,
                        onTap: () {
                          controller.equalIndex(4, context);
                        },
                        size: size,
                        index: controller.index,
                        selectedIndex: 4,
                      ),
                      DrawerItem(
                        head: "Reports",
                        icon: Icons.report,
                        onTap: () {
                          controller.equalIndex(5, context);
                        },
                        size: size,
                        index: controller.index,
                        selectedIndex: 5,
                      ),
                      DrawerItem(
                        head: "Log Out",
                        icon: Icons.logout_rounded,
                        onTap: () {
                          FirebaseAuth.instance.signOut().whenComplete(() {
                            SharedPreferences.getInstance().then((value) {
                              value.setString("auth", "");
                            }).whenComplete(() {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SplashScreen()),
                                  (route) => false);
                            });
                          });
                        },
                        index: controller.index,
                        selectedIndex: 6,
                        size: size,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: controller.pages[controller.index],
          );
        },
      ),
    );
  }
}
