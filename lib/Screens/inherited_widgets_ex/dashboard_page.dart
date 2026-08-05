import 'package:flutter/material.dart';
import 'package:fluttercourse/screens/inherited_widgets_ex/user_profile.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: true,
        title: Text("Inherited Widget"),
      ),
      body: const Center(child: UserProfile()),
    );
  }
}