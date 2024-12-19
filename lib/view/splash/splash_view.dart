import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_on/gen/assets.gen.dart';
import 'package:ride_on/view/customNavigation/custom_navigation_view.dart';
import 'package:ride_on/view/login/login_view.dart';
import 'package:ride_on/viewmodel/provider/auth_viewmodel.dart';

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
      () {
        var val =
            Provider.of<AuthViewmodel>(context, listen: false).getUserLogin();
        if (val) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const CustomNavigationView(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.rideOnLogo.image(),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
