
import 'package:flutter/material.dart';

import 'core/constant/app_string.dart';
import 'screens/flashpage/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        scaffoldBackgroundColor: Theme.of(context).cardColor,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}