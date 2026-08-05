import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart ';
import 'package:fluttercourse/grocery_store_app/data/dummy_data.dart';
import 'package:fluttercourse/grocery_store_app/models/product.dart';
import 'package:fluttercourse/grocery_store_app/models/store.dart';

import '../models/data/dummy_data.dart';
import '../models/product.dart';

class StoreScreen extends StatefulWidget {
  final Store store;

  const StoreScreen({super.key, required this.store});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late List<Product> allProducts;
  late List<Product> filteredProducts;

  String selectedCategory = "All";

  @override
  void initState() {
    super.initState();

    allProducts = products
        .where((product) => product.storeId == widget.store.id)
        .toList();

    filteredProducts = allProducts;
  }

  List<String> get categories {
    final list = allProducts.map((e) => e.category).toSet().toList();
    return ["All", ...list]; // ["All", "vegetables", "fruits"]
  }

  void filterCategory(String category) {
    setState(() {
      selectedCategory = category;

      if (category == "All") {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts
            .where((e) => e.category == category)
            .toList();
      }
    });
  }

  void searchProduct(String value) {
    final categoryProduct = selectedCategory == "All"
        ? allProducts
        : allProducts.where((e) => e.category == selectedCategory).toList();

    setState(() {
      filteredProducts = categoryProduct
          .where((e) => e.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.orangeAccent.shade200,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            titleSpacing: 0,
            // title: Text(
            //   widget.store.name,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 24,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: widget.store.image),
                  Container(color: Colors.black38),
                  Positioned(
                    left: 20,
                    bottom: 25,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.store.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.delivery_dining,
                              color: Colors.white,
                            ),
                            Text(
                              widget.store.deliveryTime,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                onChanged: searchProduct,
                decoration: InputDecoration(
                  hintText: "Search Products...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  final selected = category == selectedCategory;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: selected,
                      onSelected: (_) => filterCategory(category),
                      selectedColor: Colors.green,
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text("${filteredProducts.length} Products"),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((_, index) {
                final product = filteredProducts[index];
                return Container(
                  decoration: BoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: CachedNetworkImage(
                                imageUrl: product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            product.category,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "₹${product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {},
                                child: Text("Add"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }, childCount: filteredProducts.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: .68,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
