import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttercourse/models/user.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserListScreenSate();
}

class _UserListScreenSate extends State<UserListScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    final jsonString = await rootBundle.loadString("assets/users.json");

    final List<dynamic> jsonData = json.decode(jsonString);

    setState(() {
      users = jsonData.map((e) => User.fromJson(e)).toList();
    });
  }

  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Lists Screen", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: users.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.redAccent),
            Text("User data is empty"),
          ],
        ),
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: CachedNetworkImage(
                  cacheKey: user.profileImage,
                  imageUrl: user.profileImage,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    width: 60,
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) {
                    return const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person),
                    );
                  },
                ),
              ),
              title: Row(
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Text("Age: ${user.age.toString()}"),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  deleteUser(index);
                },
                icon: Icon(Icons.delete),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.email),
                  Text(user.phone),
                  Text("Lives in ${user.city}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}