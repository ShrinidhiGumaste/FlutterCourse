import 'package:flutter/material.dart';

import '../screens/counterApp.dart';
import '../screens/todoApp.dart';
import '../screens/user_list_screen.dart';

class DemoTabScreen extends StatelessWidget {
  const DemoTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              const Tab(icon: Icon(Icons.bookmark_border)),
              const Tab(icon: Icon(Icons.favorite_outline)),
              const Tab(icon: Icon(Icons.error_outline)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: UserListScreen()),
            Center(child: CounterPage()),
            Center(child: TodoHomeScreen()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Hey, Hi"),
                duration: Duration(milliseconds: 500),
                showCloseIcon: true,
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
