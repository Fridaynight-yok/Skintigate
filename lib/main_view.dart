import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skintigate/authen_view/login.dart';
import 'package:skintigate/home_view/home.dart';
import 'package:skintigate/profile_view/profile.dart';
import 'package:skintigate/saved_view/saved.dart';
import 'package:skintigate/scan_view/scan_view.dart';

//ห้ามยุ่ง เสร็จแล้ว

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int index = Get.arguments;
  List<Widget> screen = [Home(), ScanView(), Saved(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Color.fromRGBO(13, 152, 106, 1),
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          index = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "หน้าหลัก",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.fullscreen), label: "สแกน"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "ถูกใจ",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "โปรไฟล์"),
        ],
      ),
    );
  }
}
