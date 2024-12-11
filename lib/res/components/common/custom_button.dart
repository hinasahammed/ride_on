import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onPressed,
      required this.btnText,
      this.isloading = false});
  final void Function()? onPressed;
  final String btnText;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      onPressed: onPressed,
      child: isloading
          ? CircularProgressIndicator(
              color: theme.colorScheme.onPrimary,
            )
          : Text(btnText),
    );
  }
}
