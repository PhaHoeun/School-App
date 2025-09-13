import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      child: Center(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Lottie.asset('assets/animation/loading.json'),
      )),
    );
  }
}
