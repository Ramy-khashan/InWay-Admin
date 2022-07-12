import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/flashpage/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan.shade900,
        scaffoldBackgroundColor: Theme.of(context).cardColor,
        primarySwatch: Colors.blue,
      ),
      home: const FlashScreen(),
    );
  }
}
