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
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),
          Center(
            child: Image.asset(
              'assets/images/sk2.png', // make sure this path is correct
              height: 250,
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
                  "Facial Treatment",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204C3E),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "For: normal, combination, and dull skin.",
                  style: TextStyle(color: Color(0xFF204C3E)),
                ),
                const Text(
                  "Age group: Ideal for ages 20–40+",
                  style: TextStyle(color: Color(0xFF204C3E)),
                ),
                const Text(
                  "Recommended for sensitive skin?",
                  style: TextStyle(color: Color(0xFF204C3E)),
                ),
                const Row(
                  children: [
                    Icon(Icons.warning, size: 16, color: Colors.orange),
                    SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        "Use with caution. Parabens and sorbic acid may cause irritation in very sensitive skin",
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Skincare routine step: This product should be used after toner and before moisturizer, typically in the essence or serum step.",
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
                        text: "Galactomyces = brighten, hydrate",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Price: \$\$",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF204C3E),
                  ),
                ),
                const SizedBox(height: 4),
                InkWell(
                  onTap: _launchURL,
                  child: const Text(
                    "Buy: https://s.shopee.co.th/2B3DdE9YOo",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
