import 'package:flutter/material.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Si Peeling...',
      'size': '30 ml',
      'oldPrice': '\฿240',
      'newPrice': '\฿180',
      'rating': 4.6,
      'image': 'assets/images/product1.png',
    },
    {
      'name': 'Met bobo...',
      'size': '80 ml',
      'oldPrice': '',
      'newPrice': '\฿150',
      'rating': 4.6,
      'image': 'assets/images/product2.png',
    },
    {
      'name': 'Freshly Face...',
      'size': '120 ml',
      'oldPrice': '\฿350',
      'newPrice': '\฿250',
      'rating': 4.6,
      'image': 'assets/images/product3.png',
    },
    {
      'name': 'Body Soap',
      'size': '250 ml',
      'oldPrice': '',
      'newPrice': '\฿1800',
      'rating': 4.6,
      'image': 'assets/images/product4.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Saved",
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final item = products[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 249, 249, 249),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      "https://www.konvy.com/static/team/2024/0503/17147356019660_600x600.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['size'],
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (item['oldPrice'] != '')
                      Text(
                        item['oldPrice'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    if (item['oldPrice'] != '') const SizedBox(width: 6),
                    Text(
                      item['newPrice'],
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      item['rating'].toString(),
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
