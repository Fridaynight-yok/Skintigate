import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skintigate/authen_view/login.dart';
import 'package:skintigate/authen_view/register.dart';
import 'package:skintigate/home_view/home.dart';
import 'package:skintigate/landing_view/landing_page.dart';
import 'package:skintigate/main_view.dart';
import 'package:skintigate/product_detail_view/product_detail.dart';
import 'package:skintigate/profile_view/profile.dart';
import 'package:skintigate/scan_view/scan_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Skintigate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => LandingPage()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/register", page: () => Register()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/scan", page: () => ScanView()),
        GetPage(name: "/profile", page: () => Profile()),
        GetPage(name: "/mainview", page: () => MainView()),
        GetPage(name: "/product", page: () => ProductDetail()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Home")));
  }
}
