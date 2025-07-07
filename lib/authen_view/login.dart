import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skintigate/profile_view/profile.dart';
import 'package:skintigate/util/storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    final inputEmail = emailController.text.trim();
    final inputPassword = passwordController.text.trim();
    try {
      UserCredential userInfo = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: inputEmail,
            password: inputPassword,
          );
      if (userInfo.user != null) {
        Storage().setUserId(userInfo.user!.uid);
        Get.offAllNamed("/mainview", arguments: 3);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Login fails")));
      }
    } catch (err) {
      Get.snackbar("Login fails", "Please try again");
    }
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .18),
              Text(
                " Log in",
                style: TextStyle(
                  fontSize: 23,
                  color: Color.fromRGBO(32, 76, 75, 1),
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hintText: "อีเมล",
                ),
              ),
              SizedBox(height: 18),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hintText: "รหัสผ่าน",
                ),
              ),
              SizedBox(height: 18),

              ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "เข้าสู่ระบบ",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text("ไม่มีบัญชี?", style: TextStyle(fontSize: 15)),
              InkWell(
                onTap: () {
                  Get.toNamed("/register");
                },
                child: Text(
                  "สมัคร",
                  style: TextStyle(
                    color: Color.fromRGBO(13, 152, 106, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
