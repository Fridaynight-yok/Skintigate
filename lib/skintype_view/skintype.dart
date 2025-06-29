import 'package:flutter/material.dart';

class SkinTypePage extends StatefulWidget {
  const SkinTypePage({super.key});

  @override
  State<SkinTypePage> createState() => _SkinTypePageState();
}

class _SkinTypePageState extends State<SkinTypePage> {
  final List<String> skinTypes = [
    'Trending',
    'Dry',
    'Aging',
    'Wrinkles',
    'Hair Fall',
    'Acne Scar',
    'Blackhead',
    'Oily',
    'Brightening',
    'Dull',
    'Skin Burn',
  ];

  String selected = 'Trending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Icon
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search products",
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
                "Browse by Skin Types",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
