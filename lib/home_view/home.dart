import 'package:flutter/material.dart';

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
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
                        "Acne",
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
                        "Dry",
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
                        "Aging",
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
              child: Stack(
                children: [
                  Image.network(
                    "https://assets.central.co.th//adobe/dynamicmedia/deliver/dm-aid--cfa34aa7-47d3-487d-b0fb-3c8eebb17d29/sk-ii-online-sk2hrftessence160ml-cds12035687-1.jpg?preferwebp=true&quality=60",
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
