import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isFavorite = false;

  void _launchURL() async {
    final Uri url = Uri.parse("https://s.shopee.co.th/2B3DdE9YOo");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: const Color.fromARGB(255, 234, 114, 106),
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.network(
                'https://img.kingpowerclick.com/cdn-cgi/image/format=auto/kingpower-com/image/upload/w_640,h_640/v1677124261/prod/232275-l1.jpg', // make sure this path is correct
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF5ED), // soft green background
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFB5CDBA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "SK-II Facial Treatment Essense",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF204C3E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text.rich(
                    TextSpan(
                      text: "ผิวที่แนะนำ: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF204C3E),
                      ),
                      children: [
                        TextSpan(
                          text: "ผิวที่แนะนำ: ผิวแห้ง, ผิวหมองคล้ำ, ผิวมัน",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                      text: "อายุที่แนะนำ: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF204C3E),
                      ),
                      children: [
                        TextSpan(
                          text:
                              "เหมาะกับอายุ 20 ปีขึ้นไปโดยเฉพาะช่วง 25-40 ปี ที่เริ่มมีปัญหาผิวจากความเครียด อายุ และแสงแดด เพราะ Galactomyces จะช่วยเรื่องผิวหมอง รอยแดง และผิวขาดน้ำ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "หมาะกับผิวแพ้ง่ายไหม?",
                    style: TextStyle(
                      color: Color(0xFF204C3E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.warning, size: 16, color: Colors.orange),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          " มีส่วนผสมที่ให้ความชุ่มชื้นและช่วยฟื้นฟู  แต่มี Methylparaben, Sorbic Acid และ Sodium Benzoate ซึ่งอาจก่อให้เกิดการระคายเคืองกับคนที่ผิวแพ้ง่ายมาก",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "ขั้นตอนในสกินแคร์รูทีน: ใช้ในขั้นตอน Essence / หลังโทนเนอร์",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  const Text.rich(
                    TextSpan(
                      text: "Key Ingredients: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF204C3E),
                      ),
                      children: [
                        TextSpan(
                          text:
                              "Galactomyces Ferment Filtrate (กว่า 90%) ช่วยให้ผิวกระจ่างใส สมดุลน้ำมัน ลดความหมองคล้ำ เพิ่มความเรียบเนียน และฟื้นฟูผิวจากความเครียดและมลภาวะ",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text.rich(
                    TextSpan(
                      text: "ราคา: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF204C3E),
                      ),
                      children: [
                        TextSpan(
                          text: "฿฿฿฿",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 237, 106, 97),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: _launchURL,
                    child: const Text.rich(
                      TextSpan(
                        text: "กดลิงค์เพื่อซื้อ: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Color(0xFF204C3E),
                        ),
                        children: [
                          TextSpan(
                            text: "https://s.shopee.co.th/2B3DdE9YOo",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
