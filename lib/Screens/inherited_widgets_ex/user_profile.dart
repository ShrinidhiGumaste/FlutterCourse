import 'package:flutter/material.dart';
import 'package:fluttercourse/screens/inherited_widgets_ex/user_provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});


  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context);

    return Card(
      margin: EdgeInsets.all(23),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person),
            const SizedBox(height: 24),
            Text("User Name: ${user.userName}"),
            const SizedBox(height: 24),
            Text("Email: ${user.email}"),
          ],
        ),
      ),
    );
  }
}