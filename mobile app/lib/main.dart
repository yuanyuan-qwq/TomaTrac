import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:workshop2/ui/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Onboarding Screen',
      builder: EasyLoading.init(),
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
