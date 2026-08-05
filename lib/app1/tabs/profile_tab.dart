import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile information
              const CircleAvatar(
                radius: 56,
                backgroundImage: CachedNetworkImageProvider(
                  "https://static.vecteezy.com/system/resources/thumbnails/067/476/284/small_2x/gold-letter-s-logo-queen-crown-woman-profile-vector.jpg",
                ),
              ),
              const SizedBox(height: 16),
              const Text("Shinu"),
              const Text("shinu@gmail.com"),
              const SizedBox(height: 16),

              // edit button
              ElevatedButton(onPressed: () {}, child: Text("Edit Profile")),
              const SizedBox(height: 16),

              // Stats card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Posts"),
                            const SizedBox(height: 5),
                            Text("20"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Following"),
                            const SizedBox(height: 5),
                            Text("1"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Followers"),
                            const SizedBox(height: 5),
                            Text("10M"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Text(
                "App Settings",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 8),
              // Menu/ Settings
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Manage Account"),
                      subtitle: Text("View or edit you account settings"),
                      trailing: Icon(Icons.navigate_next, size: 16),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text("Notifications"),
                      trailing: Icon(Icons.navigate_next, size: 16),
                    ),
                    Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.lock_outline),
                      title: Text("Privacy"),
                      trailing: Icon(Icons.navigate_next, size: 16),
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Help & Support"),
                      trailing: Icon(Icons.navigate_next, size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// #orderID, ItemName, PurchaseDate, priceofitem Quantity totalPrice
