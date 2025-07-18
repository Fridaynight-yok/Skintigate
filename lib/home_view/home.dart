import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController =
      TextEditingController(); //variable for search input
  List<Map<String, dynamic>> filteredProducts =
      []; //variable for filtering products for search bar

  List<Map<String, dynamic>> productAll =
      []; //variable for fetching all products
  List<Map<String, dynamic>> productHighlight = [];

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
        'highlight': data['highlight'] ?? false,
        'ingredients': data['ingredients'] ?? '',
        'sensitivity': data['sensitivity'] ?? '',
        'skinmatch': data['skinmatch'] ?? '',
        'agematch': data['agematch'] ?? '',
        'routine': data['routine'] ?? '',
        'orderlink': data['orderlink'] ?? '',
      };
    }).toList();
  }

  Future<void> getProductAll() async {
    productAll = await fetchProducts();
    productHighlight = productAll.where((e) => e['highlight']).toList();
    filteredProducts = List.from(productAll); // initially show all
    setState(() {});
  }

  @override
  void initState() {
    getProductAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/home_page_.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          gaplessPlayback: true,
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Get.toNamed("/");
              },
              icon: Icon(Icons.arrow_back),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "ค้นหาสินค้า",
                    hintStyle: GoogleFonts.athiti(
                      fontSize: 18,
                      color: Color.fromRGBO(35, 96, 77, 1),
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(35, 96, 77, 1),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  onChanged: (value) {
                    final query = value.toLowerCase();
                    setState(() {
                      filteredProducts = productAll.where((product) {
                        final name = product['name']
                            .toString()
                            .toLowerCase()
                            .trim();

                        final brand = product['brand']
                            .toString()
                            .toLowerCase()
                            .trim();

                        return name.contains(query) || brand.contains(query);
                      }).toList();
                    });
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (searchController.text.isEmpty) ...[
                          SizedBox(height: 18),
                          Text(
                            "สินค้าแนะนำ",
                            style: GoogleFonts.athiti(
                              fontSize: 21,
                              color: Color.fromRGBO(35, 96, 77, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 310,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: productHighlight.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return _cardProductHighlight(
                                  productHighlight[index],
                                  width: 220,
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "สินค้าทั้งหมด",
                            style: GoogleFonts.athiti(
                              fontSize: 21,
                              color: Color.fromRGBO(35, 96, 77, 1),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                        GridView.count(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),

                          crossAxisCount: 2,
                          childAspectRatio: 9 / 16,
                          children: <Widget>[
                            ...filteredProducts.map(
                              (e) => _cardProductHighlight(e),
                            ), //update to ...filteredProducts.map
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InkWell _cardProductHighlight(Map item, {double width = 180}) {
    return InkWell(
      onTap: () {
        Get.toNamed("/product", arguments: item);
      },
      child: Container(
        width: width,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: item['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF204C3E),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 6),
                  Text(
                    item['ingredients'],
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "4.6",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                    ],
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
