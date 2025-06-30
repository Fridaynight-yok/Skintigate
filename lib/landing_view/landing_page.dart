import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:skintigate/util/storage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/first_page_.png",
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                OutlinedText(
                  text: Text(
                    "One click to unlock\nyour perfect skin\nmatch",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(32, 76, 62, 1),
                    ),
                  ),
                  strokes: [
                    OutlinedTextStroke(color: Colors.white, width: 2.4),
                  ],
                ),

                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/mainview", arguments: 0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, .8),
                    side: BorderSide(color: Color.fromRGBO(10, 107, 75, 0.698)),
                    elevation: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 2),
                        Text(
                          "ค้นหาสินค้า",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(35, 96, 77, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/mainview", arguments: 1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(152, 215, 194, 0.6),
                    side: BorderSide(color: Color.fromRGBO(10, 107, 75, 0.698)),
                    elevation: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fullscreen),
                        SizedBox(width: 2),
                        Text(
                          "สแกนส่วนผสม",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(35, 96, 77, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (Storage().isLogin()) {
                      Get.toNamed("/mainview", arguments: 3);
                    } else {
                      Get.toNamed('/login');
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                    elevation: 20,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 2),
                        Text(
                          "โปรไฟล์",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(253, 254, 254, 1),
                          ),
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
}
