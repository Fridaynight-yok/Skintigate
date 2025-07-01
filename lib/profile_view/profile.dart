import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/storage.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController bdayController;
  bool _isEdit = false;
  QueryDocumentSnapshot<Map<String, dynamic>>? _queryDoc;

  Future<void> fetchUser() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: Storage().getUserId())
          .get();

      _queryDoc = doc.docs.first;
      final Map data = _queryDoc!.data();

      nameController.text = data['name'];
      emailController.text = data['email'];
      bdayController.text = data['bday'];
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<void> updateData() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final bday = bdayController.text.trim();

    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_queryDoc!.id)
          .update({'name': name, 'email': email, 'bday': bday});

      _isEdit = true;
      setState(() {});
      fetchUser();
      Get.snackbar("success", "บันทึกสำเร็จ");
    } catch (e) {
      Get.snackbar("warning", "something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    bdayController = TextEditingController();
    emailController = TextEditingController();
    fetchUser();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bdayController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: InkWell(child: Icon(Icons.arrow_back)),
        ),
      ),
      body: Column(
        children: [
          // Profile picture & name
          Container(
            width: double.infinity, // ให้ภายใน card ขยายเต็มแนวกว้าง
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ), // padding ภายในเล็กน้อยให้ดูหายใจ
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: AssetImage("assets/icon/app_icon.png"),
              ),
              title: const Text(
                "Welcome to Skintigate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(32, 76, 75, 1),
                ),
              ),
              subtitle: const Text(
                "Your skin is our priority",
                style: TextStyle(color: Color.fromRGBO(32, 76, 75, 1)),
              ),
              trailing: IconButton(
                onPressed: () {
                  _isEdit = !_isEdit;
                  setState(() {});
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              readOnly: _isEdit,
              controller: nameController,
              decoration: InputDecoration(
                hintText: "ชื่อ",
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(height: 0.1, color: const Color.fromARGB(255, 189, 188, 188)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              readOnly: _isEdit,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "อีเมล",
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(height: 1, color: const Color.fromARGB(255, 189, 188, 188)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              readOnly: _isEdit,
              controller: bdayController,
              decoration: InputDecoration(
                hintText: "วันเกิด",
                border: InputBorder.none,
              ),
            ),
          ),
          Divider(height: 1, color: const Color.fromARGB(255, 189, 188, 188)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              readOnly: _isEdit,
              decoration: InputDecoration(
                hintText: "เพศ",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 24),
          // Save Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B8F64),
                // shape: StadiumBorder(),
                // minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {
                updateData();
              },
              child: SizedBox(
                width: 50,
                height: 40,
                child: Center(
                  child: Text("บันทึก", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Logout
          TextButton(
            onPressed: () {
              Storage().removeUserId();

              ///เอาออกจากระบบ
              Get.offAllNamed('/');
            },
            child: Text(
              "ออกจากระบบ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
