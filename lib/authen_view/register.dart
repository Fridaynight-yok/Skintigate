import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skintigate/authen_view/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController bdayController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    bdayController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    confirmPasswordController.dispose();
    bdayController.dispose();
  }

  Future<void> registerUser() async {
    final inputName = nameController.text
        .trim(); //no space bar added when user input name
    final inputPassword = passwordController.text.trim();
    final inputEmail = emailController.text.trim();
    final inputConfirmpassoword = confirmPasswordController.text.trim();
    final inputbday = bdayController.toString();

    if (inputPassword != inputConfirmpassoword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("password and confirm password do not match")),
      );
      return;
    }
    try {
      UserCredential userInfo = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: inputEmail,
            password: inputPassword,
          );
      if (userInfo.user != null) {
        final String uid = userInfo.user!.uid; //! = รับประกันว่าจะไม่ null
        await FirebaseFirestore.instance.collection("members").doc(uid).set({
          "name": inputName,
          "email": inputEmail,
          "bday": inputbday,
          "createAt": FieldValue.serverTimestamp(),
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Register complete")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("something went wrong ${e}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * .10),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 23,
                color: Color.fromRGBO(32, 76, 75, 1),
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 40,
              child: TextField(
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
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 40,
              child: TextField(
                controller: passwordController,
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
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 40,
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hintText: "ยืนยันรหัสผ่าน",
                ),
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 40,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hintText: "ชื่อ",
                ),
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 40,
              child: TextField(
                onTap: () {
                  print("open dialogue date time");
                },
                readOnly: true,
                controller: bdayController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  hintText: "วันเกิด",
                ),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(13, 152, 106, 1),
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "สมัคร",
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text("มีบัญชีแล้ว?", style: TextStyle(fontSize: 15)),
            Text(
              "เข้าสู่ระบบ",
              style: TextStyle(
                color: Color.fromRGBO(13, 152, 106, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
