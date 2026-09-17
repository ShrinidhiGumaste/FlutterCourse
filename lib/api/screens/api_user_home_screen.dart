import 'package:flutter/material.dart';
import 'package:fluttercourse/api/models/api_user.dart';

import '../services/api_service.dart';
import '../widgets/api_user_card.dart';

class ApiUserHomeScreen extends StatefulWidget {
  const ApiUserHomeScreen({super.key});

  @override
  State<ApiUserHomeScreen> createState() => _ApiUserHomeScreenState();
}

class _ApiUserHomeScreenState extends State<ApiUserHomeScreen> {
  final ApiService apiService = ApiService();

  late Future<List<ApiUser>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = apiService.fetchUsers();
  }

  Future<void> refreshUsers() async {
    setState(() {
      usersFuture = apiService.fetchUsers();
    });
    await usersFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User"), titleSpacing: 0),
      body: FutureBuilder(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 60,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Something went wrong!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: refreshUsers,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data"));
          }

          final users = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: refreshUsers,
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ApiUserCard(user: user);
              },
            ),
          );
        },
      ),
    );
  }
}
