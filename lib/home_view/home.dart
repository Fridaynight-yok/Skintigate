import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> productAll = [];
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
    print(productHighlight.length);
    setState(() {});
  }

  @override
  void initState() {
    getProductAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.toNamed("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "ค้นหาสินค้า",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // SizedBox(height: 18),
            // Row(
            //   children: [
            //     Text(
            //       "ค้นหาตามหมวดหมู่",
            //       style: TextStyle(
            //         color: Color.fromRGBO(32, 76, 62, 1),
            //         fontSize: 20,
            //       ),
            //     ),
            //     Spacer(),
            //     InkWell(
            //       onTap: () {
            //         Get.toNamed('/skintype');
            //       },
            //       child: Text(
            //         "ดูทั้งหมด",
            //         style: TextStyle(
            //           color: Color.fromRGBO(32, 76, 62, 1),
            //           decoration: TextDecoration.underline,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     ActionChip(
            //       label: SizedBox(
            //         width: 50,
            //         child: Center(
            //           child: Text(
            //             "สิว",
            //             style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
            //           ),
            //         ),
            //       ),
            //       backgroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadiusGeometry.circular(20),
            //         side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
            //       ),
            //       onPressed: () {},
            //     ),
            //     ActionChip(
            //       label: SizedBox(
            //         width: 50,
            //         child: Center(
            //           child: Text(
            //             "ผิวแห้ง",
            //             style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
            //           ),
            //         ),
            //       ),
            //       backgroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadiusGeometry.circular(20),
            //         side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
            //       ),
            //       onPressed: () {},
            //     ),
            //     ActionChip(
            //       label: SizedBox(
            //         width: 50,
            //         child: Center(
            //           child: Text(
            //             "ผิวมีอายุ",
            //             style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
            //           ),
            //         ),
            //       ),
            //       backgroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadiusGeometry.circular(20),
            //         side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
            //       ),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18),
                    Text(
                      "สินค้าแนะนำ",
                      style: TextStyle(
                        color: Color.fromRGBO(32, 76, 62, 1),
                        fontSize: 20,
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
                      style: TextStyle(
                        color: Color.fromRGBO(32, 76, 62, 1),
                        fontSize: 20,
                      ),
                    ),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      crossAxisCount: 2,
                      childAspectRatio: 9 / 16,
                      children: <Widget>[
                        ...productAll.map((e) => _cardProductHighlight(e)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
              child: Image.network(
                item['image'],
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
