import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkinTypePage extends StatefulWidget {
  const SkinTypePage({super.key});

  @override
  State<SkinTypePage> createState() => _SkinTypePageState();
}

class _SkinTypePageState extends State<SkinTypePage> {
  final List<String> skinTypes = [
    'สินค้านิยม',
    'ผิวแห้ง',
    'ผิวมีอายุ',
    'ริ้วรอย',
    'ผมร่วง',
    'รอยแผลเป็นจากสิว',
    'สิวหัวดำ',
    'ผิวมัน',
    'ผิวกระจ่างใส',
    'ผิวหมองคล้ำ',
    'ผิวไหม้แดด',
  ];

  String selected = 'สินค้านิยม';

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Icon
            const Align(alignment: Alignment.centerLeft),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "ค้นหาสินค้า",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              "ค้นหาตามหมวดหมู่",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(32, 76, 62, 1),
              ),
            ),
            const SizedBox(height: 12),

            // Filter Chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: skinTypes.map((type) {
                final isSelected = selected == type;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = type;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF2AA279)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF2AA279)),
                    ),
                    child: Text(
                      type,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF2AA279),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
