import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:school_app/cores/auth/auth_provider/auth_provider.dart';
import 'package:school_app/cores/auth/widget/animations.dart';
import 'package:school_app/cores/auth/widget/bg_data.dart';
import 'package:school_app/cores/auth/widget/text_utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;
  bool showOption = false;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          Scaffold(
            floatingActionButton: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 49,
              width: double.infinity,

              child: Row(
                children: [
                  Expanded(
                    child: showOption
                        ? ShowUpAnimation(
                            delay: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: bgList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 30,

                                    backgroundColor: selectedIndex == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                          bgList[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(width: 20),
                  showOption
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              showOption = false;
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              showOption = true;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(
                                  bgList[selectedIndex],
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgList[selectedIndex]),
                  fit: BoxFit.fill,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withValues(alpha: 0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Center(
                            child: TextUtil(
                              text: "Log In",
                              weight: true,
                              size: 30,
                            ),
                          ),
                          const Spacer(),
                          TextUtil(text: "Username"),
                          Container(
                            height: 35,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white),
                              ),
                            ),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                context.read<AuthProvider>().username = v;
                              },
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                          const Spacer(),
                          TextUtil(text: "Password"),
                          Container(
                            height: 35,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white),
                              ),
                            ),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                fillColor: Colors.white,
                                border: InputBorder.none,
                              ),
                              onChanged: (v) {
                                context.read<AuthProvider>().password = v;
                              },
                              onFieldSubmitted: (_) {
                                context.read<AuthProvider>().onLogIn();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Gap(10),
                          Align(
                            alignment: AlignmentGeometry.centerRight,
                            child: TextUtil(
                              text: "FORGET PASSWORD",
                              size: 12,
                              weight: true,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              if (context
                                      .read<AuthProvider>()
                                      .username
                                      .isEmpty &&
                                  context
                                      .read<AuthProvider>()
                                      .password
                                      .isEmpty) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  curve: Curves.ease,
                                  animationDuration: const Duration(
                                    milliseconds: 800,
                                  ),

                                  CustomSnackBar.error(
                                    message:
                                        "Username and Password is required!",
                                  ),
                                );
                              } else if (context
                                  .read<AuthProvider>()
                                  .username
                                  .isEmpty) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  curve: Curves.ease,
                                  animationDuration: const Duration(
                                    milliseconds: 800,
                                  ),
                                  CustomSnackBar.error(
                                    message: "Username is required!",
                                  ),
                                );
                              } else if (context
                                  .read<AuthProvider>()
                                  .password
                                  .isEmpty) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  curve: Curves.ease,
                                  animationDuration: const Duration(
                                    milliseconds: 800,
                                  ),
                                  CustomSnackBar.error(
                                    message: "Password is required!",
                                  ),
                                );
                              } else {
                                // context.read<AuthProvider>().onLogIn();
                                debugPrint('log in--------->>>');
                              }
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              child: TextUtil(
                                text: "Log In",
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Row(
                              children: [
                                TextUtil(
                                  text: "Don't have a account?",
                                  size: 14,
                                  weight: true,
                                ),
                                Gap(5),
                                TextUtil(
                                  text: "REGISTER",
                                  size: 12,
                                  weight: true,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
