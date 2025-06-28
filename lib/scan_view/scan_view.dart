import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/scan_page_.png",
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: OutlinedText(
                    text: Text(
                      "เลือก 1 วิธี\nเพื่อสแกนส่วนผสม",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(32, 76, 62, 1),
                        fontSize: 22,
                      ),
                    ),
                    strokes: [
                      OutlinedTextStroke(color: Colors.white, width: 1.5),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "1.ก็อปปี้วางส่วนผสม ",
                style: TextStyle(
                  color: Color.fromRGBO(32, 76, 62, 1),
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 300,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "2. ถ่ายรูปส่วนผสมหลังกล่อง",
                style: TextStyle(
                  color: Color.fromRGBO(32, 76, 62, 1),
                  fontSize: 19,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                ),
                child: SizedBox(
                  width: 50,
                  child: Center(
                    child: Text(
                      "อัพรูป",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
