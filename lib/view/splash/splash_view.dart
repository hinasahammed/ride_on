import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ride_on/view/login/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/ride_on_logo.png"),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
