import 'package:flutter/material.dart';

class ShopMenuScreen extends StatefulWidget {
  final String shopName;
  final List foodList;

  const ShopMenuScreen({
    super.key,
    required this.shopName,
    required this.foodList,
  });

  @override
  State<ShopMenuScreen> createState() => _ShopMenuScreenState();
}

class _ShopMenuScreenState extends State<ShopMenuScreen> {
  Map<String, int> cart = {};
  int total = 0;

  @override
  Widget build(BuildContext context) {
    final items = widget.foodList
        .where((e) => e['shopName'] == widget.shopName)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shopName),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.fastfood,
                          color: Colors.blue),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(item['name']),
                      ),
                      Column(
                        children: [
                          Text("₹${item['price']}"),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                String name = item['name'];
                                int price = item['price'];

                                cart[name] =
                                    (cart[name] ?? 0) + 1;
                                total += price;
                              });
                            },
                            child: const Text("Add"),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          if (cart.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue,
              child: Column(
                children: [
                  Text("Total: ₹$total",
                      style:
                          const TextStyle(color: Colors.white)),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Order Placed")),
                      );
                      setState(() {
                        cart.clear();
                        total = 0;
                      });
                    },
                    child: const Text("Order"),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}