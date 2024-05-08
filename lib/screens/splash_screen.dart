import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:university_info/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2)); // 2 seconds delay
    Get.off(() => const HomeScreen()); // Navigate to the NextScreen using GetX
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
              'assets/images/logo.png',
            height: 110,
            width: 110,
          ),
        ), // Adjust the image path as needed
      ),
    );
  }
}