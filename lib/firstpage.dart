import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: Text("One touch to unlock your perfect skin match")),
          ElevatedButton(onPressed: () {}, child: Text("Search Product")),
          ElevatedButton(onPressed: () {}, child: Text("Scain Ingredients")),
          ElevatedButton(onPressed: () {}, child: Text("My Profile")),
        ],
      ),
    );
  }
}
