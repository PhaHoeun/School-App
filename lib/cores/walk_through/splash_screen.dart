import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/configs/router/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    Future.delayed(Duration(milliseconds: 2500), () {
      router.go('/log-in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Lottie.asset(width: 270, 'assets/animation/splash.json'),
        ),
      ),
    );
  }
}
