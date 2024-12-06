import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ride_on/model/user.dart';
import 'package:ride_on/res/components/custom_button.dart';
import 'package:ride_on/res/components/custom_textformfield.dart';
import 'package:ride_on/viewmodel/controller/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final useridController = TextEditingController();
  final passwordController = TextEditingController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/bus.png"),
            Text(
              "Login Account",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Text(
              "Welcome Back!",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(10),
            Text(
              "Please enter your Id and password details to access your account",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.8),
              ),
            ),
            const Gap(20),
            Text(
              "Enter UserId",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(10),
            CustomTextformfield(
              controller: useridController,
              labelText: "User ID",
            ),
            const Gap(20),
            Text(
              "Enter password",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(10),
            CustomTextformfield(
              controller: passwordController,
              labelText: "Password",
            ),
            const Gap(40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                isloading: isloading,
                onPressed: () {
                  setState(() {
                    isloading = true;
                  });
                  AuthController().login(
                      context,
                      User(
                        userId: useridController.text.trim(),
                        pswd: passwordController.text.trim(),
                      ));
                  setState(() {
                    isloading = false;
                  });
                },
                btnText: "Login",
              ),
            )
          ],
        ),
      ),
    ));
  }
}
