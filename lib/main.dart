import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app/constrants/wrapper_provider.dart';
import 'package:school_app/modules/home/screen/home_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: WrapperProvider.wrapperList, child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(),
    );
  }
}
