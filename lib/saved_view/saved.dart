import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Biore UV Aqua Rich Watery Essense',
      'size': '30 ml',
      'claim': 'ป้องกันแสงแดดด้วย',
      'newPrice': '฿',
      'rating': 4.6,
      'image':
          'https://www.konvy.com/static/team/2024/0503/17147356019660_600x600.jpg',
    },
    {
      'name': 'N°1 De Chanel Revitalizing Eye Serum',
      'size': '80 ml',
      'claim': 'เซรั่มบำรุงรอบดวงตา',
      'newPrice': '฿฿฿',
      'rating': 4.6,
      'image':
          'https://www.chanel.com/images/t_one/w_0.40,h_0.40,c_crop/q_auto:good,f_autoplus,fl_lossy,dpr_1.1/w_1020/n-1-de-chanel-revitalizing-eye-serum-smooths-restores-refreshes-0-53fl-oz--packshot-default-140040-9540966580254.jpg',
    },
    {
      'name': 'Cure Natural Aqua Gel',
      'size': '120 ml',
      'claim': 'เจลผลัดเซลล์ผิวอย่างอ่อนโยน',
      'newPrice': '฿',
      'rating': 4.6,
      'image':
          'https://mochimochi.nz/cdn/shop/files/curenaturalaquagel.webp?v=1685667687',
    },
    {
      'name': 'UV Sun Serum SPF50+ Pa++++',
      'size': '250 ml',
      'claim': 'กันแดดเนื้อเซรั่มซึมเร็วไม่เหนียวเหนอะ',
      'newPrice': '฿',
      'rating': 4.6,
      'image': 'https://clearnose.co.th/wp-content/uploads/2022/01/CUV_1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "สินค้าที่ถูกใจ",
          style: TextStyle(color: Color.fromRGBO(32, 76, 75, 1)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
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
                    child: CachedNetworkImage(
                      imageUrl: item['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(32, 76, 75, 1),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item['size'],
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  item['claim'] ?? "N/A",
                  style: const TextStyle(fontSize: 10, color: Colors.black),
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
