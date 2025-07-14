import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skintigate/util/storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Map item = Get.arguments;
  bool isFavorite = false;

  void _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void checkIfFavorited() async {
    final userId = Storage().getUserId();

    final existing = await FirebaseFirestore.instance
        .collection('favorites')
        .where('name', isEqualTo: item['name']) // or use a unique ID
        .where('users', isEqualTo: userId)
        .get();

    if (existing.docs.isNotEmpty) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIfFavorited();
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
        forceMaterialTransparency: true,
        actions: [
          if (Storage().getUserId() != null)
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color.fromARGB(255, 234, 114, 106),
              ),
              onPressed: () async {
                setState(() {
                  isFavorite = !isFavorite;
                });
                if (isFavorite) {
                  try {
                    final userId = await Storage().getUserId();

                    final existing = await FirebaseFirestore.instance
                        .collection('favorites')
                        .where(
                          'name',
                          isEqualTo: item['name'],
                        ) // You can also use 'id' if available
                        .where('users', isEqualTo: userId)
                        .get();

                    if (existing.docs.isEmpty) {
                      // 2. If it doesn't exist, add it
                      await FirebaseFirestore.instance
                          .collection('favorites')
                          .add({
                            ...item,
                            'users': userId,
                            'createdAt': FieldValue.serverTimestamp(),
                          });
                      print("Added to favorites!");
                    } else {
                      print("Item already in favorites.");
                    }
                  } catch (e) {
                    print("Failed to add to favorites: $e");
                  }
                } else {
                  // Optional: remove from favorites if un-favorited
                }
              },
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: item["image"], // make sure this path is correct
                width: double.infinity,
                fit: BoxFit.cover,
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
                    Text(
                      item["name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF204C3E),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "แบรนด์: ",
                        style: GoogleFonts.athiti(
                          fontSize: 14,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "${item['brand']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 237, 106, 97),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text.rich(
                      TextSpan(
                        text: "ผิวที่แนะนำ: ",
                        style: GoogleFonts.athiti(
                          fontSize: 14,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                item["skinmatch"] ??
                                "ผิวแห้ง, ผิวหมองคล้ำ, ผิวมัน",
                            style: GoogleFonts.athiti(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "อายุที่แนะนำ: ",
                        style: GoogleFonts.athiti(
                          fontSize: 14,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                item["agematch"] ??
                                "เหมาะกับอายุ 20 ปีขึ้นไปโดยเฉพาะช่วง 25-40 ปี ที่เริ่มมีปัญหาผิวจากความเครียด อายุ และแสงแดด เพราะ Galactomyces จะช่วยเรื่องผิวหมอง รอยแดง และผิวขาดน้ำ",
                            style: GoogleFonts.athiti(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "เหมาะกับผิวแพ้ง่ายไหม?: ",
                      style: GoogleFonts.athiti(
                        fontSize: 14,
                        color: Color.fromRGBO(35, 96, 77, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.warning, size: 16, color: Colors.orange),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            item["sensitivity"] ??
                                " มีส่วนผสมที่ให้ความชุ่มชื้นและช่วยฟื้นฟู  แต่มี Methylparaben, Sorbic Acid และ Sodium Benzoate ซึ่งอาจก่อให้เกิดการระคายเคืองกับคนที่ผิวแพ้ง่ายมาก",
                            style: GoogleFonts.athiti(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "ขั้นตอนในสกินแคร์รูทีน: ",
                        style: GoogleFonts.athiti(
                          fontSize: 14,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                item["routine"] ??
                                "เหมาะกับอายุ 20 ปีขึ้นไปโดยเฉพาะช่วง 25-40 ปี ที่เริ่มมีปัญหาผิวจากความเครียด อายุ และแสงแดด เพราะ Galactomyces จะช่วยเรื่องผิวหมอง รอยแดง และผิวขาดน้ำ",
                            style: GoogleFonts.athiti(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text.rich(
                      TextSpan(
                        text: "ส่วนผสม: ",
                        style: GoogleFonts.athiti(
                          fontSize: 14,
                          color: Color.fromRGBO(35, 96, 77, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "${item["ingredients"]}",
                            style: GoogleFonts.athiti(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => _launchURL(
                        item["orderlink"] ??
                            "https://s.shopee.co.th/2B3DdE9YOo",
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: "กดลิงค์เพื่อซื้อ: ",
                          style: GoogleFonts.athiti(
                            fontSize: 14,
                            color: Color.fromRGBO(35, 96, 77, 1),
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  item["orderlink"] ??
                                  "https://s.shopee.co.th/2B3DdE9YOo",
                              style: GoogleFonts.athiti(
                                fontSize: 14,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Text.rich(
                    //   TextSpan(
                    //     text: "คะแนนความชอบ: ",
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 13,
                    //       color: Color(0xFF204C3E),
                    //     ),
                    //     children: [
                    //       TextSpan(
                    //         text: item["rating"],
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.black87,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
