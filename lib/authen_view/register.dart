import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skintigate/authen_view/login.dart';
import 'package:intl/intl.dart';

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
    final inputName = nameController.text.trim();
    final inputPassword = passwordController.text.trim();
    final inputEmail = emailController.text.trim();
    final inputConfirmpassoword = confirmPasswordController.text.trim();
    final inputbday = bdayController.text;

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
        final String uid = userInfo.user!.uid;
        final users = FirebaseFirestore.instance.collection("users");
        await users.add({
          'uid': uid,
          'name': inputName,
          'email': inputEmail,
          "password": inputPassword,
          "bday": inputbday,
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
      ).showSnackBar(SnackBar(content: Text("something went wrong $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .10),
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32,
                  color: Color.fromRGBO(13, 152, 106, 1),
                  fontWeight: FontWeight.bold,
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
              ),
              SizedBox(height: 18),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
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
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      locale: Locale("th", "TH"),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Color.fromRGBO(13, 152, 106, 1),
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Color.fromRGBO(
                                  13,
                                  152,
                                  106,
                                  1,
                                ),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat(
                        'dd MMM yyyy',
                        'th',
                      ).format(pickedDate);
                      // String formattedDate =
                      //     "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.year}";
                      setState(() {
                        bdayController.text = formattedDate;
                      });
                    }
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
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                ),
                child: InkWell(
                  onTap: () {
                    registerUser();
                  },
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
              ),
              SizedBox(height: 18),
              Text("มีบัญชีแล้ว?", style: TextStyle(fontSize: 15)),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  "เข้าสู่ระบบ",
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
