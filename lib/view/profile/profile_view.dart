import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "+918237478978",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .5),
              ),
            ),
            const Spacer(),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: theme.colorScheme.onSurface,
                ),
                title: const Text("Logout"),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
