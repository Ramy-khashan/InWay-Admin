import 'package:admin/screens/mainhome/view.dart';
import 'package:admin/screens/signin/view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  SharedPreferences? preferences;
  String? fristTime;
  String? auth;
  getPref() async {
    preferences = await SharedPreferences.getInstance();

    fristTime = preferences!.getString("frist_time");
    auth = preferences!.getString("auth");
    setState(() {});
  }

  AnimationController? _animationController;
  @override
  void initState() {
    getPref();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
     Tween<Offset>(
      begin: const Offset(
        0,
        1,
      ),
      end: const Offset(0, 0),
    ).animate(_animationController!);
    _animationController!.forward().whenComplete(() {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        if (auth == "yes") {
          return const MainHomeScreen();
        } else {
          return const SignInScreen();
        }
      }), (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(_animationController!),
        child: Text(
          "InWay",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: size.shortestSide * .2,
            fontWeight: FontWeight.w900,
            fontFamily: "logo",
          ),
        ),
      ),
    ));
  }
}
