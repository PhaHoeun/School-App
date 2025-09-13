import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:school_app/cores/auth/auth_provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
      
    // });
    init();
    super.initState();
  }

  init() async {
    final auth = context.read<AuthProvider>();
    await auth.initAuth();
    auth.onGetUser(context);
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
