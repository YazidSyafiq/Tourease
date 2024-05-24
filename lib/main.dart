import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:tourease/pages/splash/splash_page.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyBfGGcYvjUe0lPH9_H69mWdoPfPPY3OfZM');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
