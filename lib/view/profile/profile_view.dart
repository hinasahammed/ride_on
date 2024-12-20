import 'package:flutter/material.dart';
import 'package:ride_on/res/components/text/body_large_text.dart';
import 'package:ride_on/res/components/text/title_large_text.dart';

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
            const TitleLargeText(
              text: "Name",
              fontWeight: FontWeight.w600,
            ),
            BodyLargeText(
              text: "+918237478978",
              textColor: theme.colorScheme.onSurface.withValues(alpha: .5),
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
