import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
                hintText: "Search products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Text(
                  "Browse by Skin Types",
                  style: TextStyle(
                    color: Color.fromRGBO(32, 76, 62, 1),
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Text(
                  "View all",
                  style: TextStyle(
                    color: Color.fromRGBO(32, 76, 62, 1),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionChip(
                  label: SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        "สิว",
                        style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
                  ),
                  onPressed: () {},
                ),
                ActionChip(
                  label: SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        "ผิวแห้ง",
                        style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
                  ),
                  onPressed: () {},
                ),
                ActionChip(
                  label: SizedBox(
                    width: 50,
                    child: Center(
                      child: Text(
                        "สูงวัย",
                        style: TextStyle(color: Color.fromRGBO(32, 76, 62, 1)),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    side: BorderSide(color: Color.fromRGBO(32, 76, 62, 1)),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              width: 180,
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
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      "https://assets.central.co.th//adobe/dynamicmedia/deliver/dm-aid--cfa34aa7-47d3-487d-b0fb-3c8eebb17d29/sk-ii-online-sk2hrftessence160ml-cds12035687-1.jpg?preferwebp=true&quality=60",
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
                          "SK-II Facial Treatment Essence",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF204C3E),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "มี PITERA ช่วยเสริมความชุ่มชื้น, ฟื้นฟูเกราะผิว และลดการระคายเคือง",
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Explore more",
              style: TextStyle(
                color: Color.fromRGBO(32, 76, 62, 1),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
