import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/grocery_store_app/models/store.dart';
import 'package:fluttercourse/grocery_store_app/screens/store_screen.dart';

import '../data/dummy_data.dart';
import '../models/data/dummy_data.dart';

class GHomeScreen extends StatefulWidget {
  const GHomeScreen({super.key});

  @override
  State<GHomeScreen> createState() => _GHomeScreenState();
}

class _GHomeScreenState extends State<GHomeScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Store> filteredStores = [];

  @override
  void initState() {
    super.initState();
    filteredStores = stores;
  }

  void searchStore(String value) {
    setState(() {
      filteredStores = stores.where((store) {
        return store.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: Column(
          children: [
            //Header
            Container(
              padding: EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: CachedNetworkImageProvider(
                          "https://media.istockphoto.com/id/1540766473/photo/young-adult-male-design-professional-smiles-for-camera.jpg?s=612x612&w=0&k=20&c=BbwgfMOtFOIJn1Km-ASix_EBbF9SHW5h0FtWbna5nFk=",
                        ),
                      ),
                      SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delivery Address"),
                            SizedBox(height: 4),
                            Text(
                              "Jayanagar, Bengaluru",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: searchController,
                    onChanged: searchStore,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search Store...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Nearby Stores",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),

            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredStores.length,
                itemBuilder: (context, index) {
                  final store = filteredStores[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StoreScreen(store: store),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: store.image,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        store.name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 18,
                                            color: Colors.orangeAccent,
                                          ),
                                          Text(store.rating),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(store.address)),
                                  ],
                                ),

                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.delivery_dining,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      store.deliveryTime,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const Spacer(),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                StoreScreen(store: store),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.store),
                                      label: const Text("Open"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     children: [
            //
            //
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}