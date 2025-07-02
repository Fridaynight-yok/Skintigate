import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewProductsFutureScreen extends StatefulWidget {
  const ViewProductsFutureScreen({super.key});

  @override
  State<ViewProductsFutureScreen> createState() =>
      _ViewProductsFutureScreenState();
}

class _ViewProductsFutureScreenState extends State<ViewProductsFutureScreen> {
  //เข้าถึงข้อมูล product_data ใน firebase
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('product_data')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': data['id'] ?? '',
        'name': data['name'] ?? '',
        'brand': data['brand'] ?? '',
        'image': data['image'] ?? '',
        'ingredients': data['ingredients'] ?? '',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("รายการสินค้า (Future)")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("ยังไม่มีสินค้าที่เพิ่ม"));
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 3,
                child: ListTile(
                  leading: Image.network(
                    product['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  ),
                  title: Text(product['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Brand: ${product['brand']}"),
                      const SizedBox(height: 4),
                      Text(
                        "Ingredients: ${product['ingredients'].toString().split(',').take(3).join(', ')}...",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
