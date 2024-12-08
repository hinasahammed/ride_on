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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/login.png",
                width: double.infinity,
                height: 400,
              ),
              Text(
                "Login to Your Account",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(10),
              Text(
                "Welcome Back, You have been missed!",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(20),
              CustomTextformfield(
                controller: useridController,
                validator: (userId) {
                  if (userId == null || userId.isEmpty) {
                    return "Enter User Id";
                  }
                  return null;
                },
                labelText: "User ID",
              ),
              const Gap(10),
              CustomTextformfield(
                controller: passwordController,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Enter Password";
                  }
                  return null;
                },
                labelText: "Password",
              ),
              const Gap(40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthController().login(
                          context,
                          User(
                            userId: useridController.text.trim(),
                            pswd: passwordController.text.trim(),
                          ));
                    }
                  },
                  btnText: "Login",
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    useridController.dispose();
    passwordController.dispose();
  }
}
