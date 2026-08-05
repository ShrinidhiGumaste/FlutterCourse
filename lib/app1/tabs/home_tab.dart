import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WELCOME 😎",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Shinu",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  CircleAvatar(
                    radius: 48,
                    backgroundImage: CachedNetworkImageProvider(
                      "https://pngfre.com/wp-content/uploads/hanuman-36-281x300.png",
                    ),
                  ),
                ],
              ),

              Divider(thickness: 0.8),
              SizedBox(height: 8),

              // Balance Card
              Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellowAccent,
                      Colors.orange,
                      Colors.black.withValues(alpha: .50),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      blurRadius: 42,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    const Text(
                      "₹ 5000",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "*** ** 5290",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Text(
                          "VISA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text("Quick Actions"),
              const SizedBox(height: 16),

              Row(
                children: [
                  actionButton(Icons.send, "Send Money"),
                  actionButton(Icons.receipt_long, " My Transaction"),
                  actionButton(Icons.add_card, "Add Cards"),
                  Spacer(),
                  actionButton(Icons.more_horiz, "More"),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Analytics View",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text("View All", style: TextStyle(color: Colors.blue)),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                height: 220,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Monthly Spending",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          bar(hei: 60, col: Colors.redAccent.withValues(alpha: 0.60)),
                          bar(hei: 60, col: Colors.redAccent.withValues(alpha: 0.60)),
                          bar(hei: 150, col: Colors.redAccent.withValues(alpha: 0.60)),
                          bar(hei: 60, col: Colors.redAccent.withValues(alpha: 0.60)),
                          bar(hei: 60, col: Colors.redAccent.withValues(alpha: 0.60)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Recent Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 8),

              transaction(
                Icons.shopping_bag,
                "Myntra Purchase",
                "Debited at online shopping items",
                "- 500",
              ),
              transaction(
                Icons.restaurant,
                "Restaurant",
                "For 2 Peoples",
                "- 750",
              ),
              transaction(
                Icons.movie,
                "Movie Ticket",
                "Movie tonight at PVR",
                "- 450",
              ),
              transaction(
                Icons.public_rounded,
                "Project Sales",
                "Hurray, Earned",
                "+ 10000",
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget actionButton(IconData icon, String title) {
    return Column(
      spacing: 2,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 60,
          width: 60,
          child: Icon(icon),
        ),
      ],
    );
  }

  static Widget bar({required double hei, Color? col}) {
    return Container(
      height: hei,
      width: 25,
      decoration: BoxDecoration(
        color: col ?? Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  static Widget transaction(
    IconData icon,
    String label,
    String trDescp,
    String amount,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        trailing: Text(
          amount,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        title: Text(label),
        subtitle: Text(trDescp),
        leading: Icon(icon),
      ),
    );
  }
}
