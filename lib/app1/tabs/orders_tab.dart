import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(title: const Text("My Orders"), centerTitle: true),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 20),

            //---------------Order 1-----------------
            orderCard(
              orderID: "#1001",

              itemName: "Apple iPhone 17 Pro",

              purchaseDate: "27 July 2026",

              price: "₹1,49,999",

              status: "Delivered",
            ),

            //----------------Order 2---------------
            orderCard(
              orderID: "#1002",

              itemName: "Apple Watch Ultra",

              purchaseDate: "25 July 2026",

              price: "₹89,999",

              status: "Shipped",
            ),

            //----------------Order 3---------------
            orderCard(
              orderID: "#1003",

              itemName: "MacBook Pro M6",

              purchaseDate: "20 July 2026",

              price: "₹2,19,999",

              status: "Delivered",
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget orderCard({
    required String orderID,
    required String itemName,
    required String purchaseDate,
    required String price,
    required String status,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Order ID : $orderID",

                style: const TextStyle(
                  fontWeight: FontWeight.bold,

                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 12),

              Text("Item Name : $itemName"),

              const SizedBox(height: 8),

              Text("Purchase Date : $purchaseDate"),

              const SizedBox(height: 8),

              Text("Price : $price"),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Text(
                    status,

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
