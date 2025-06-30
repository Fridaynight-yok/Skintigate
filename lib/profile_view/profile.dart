import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic>? user;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController bdayController;
  bool _isEdit = false;

  Future<void> fetchUser() async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection("members")
          .doc(uid)
          .get();
      if (doc.exists) {
        setState(() {
          nameController.text = doc.data()?["name"] ?? 'no name';
          emailController.text = doc.data()?['email'] ?? "no email";
          bdayController.text = doc.data()?['bday'] ?? "N/A";
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("something went wrong")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("something went wrong")));
    }
  }

  Future<void> updateData() async {
    final name = nameController.text.trim();

    try {
      await FirebaseFirestore.instance.collection("members").doc(uid).update({
        'name': name,
      });
      fetchUser();
    } catch (e) {
      Get.snackbar("warning", "something went wrong");
    }
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
          Card(
            elevation: 4, // ความสูงของเงา
            margin: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 10,
            ), // ระยะห่างรอบ Card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // มุมโค้ง
            ),
            child: Container(
              width: double.infinity, // ให้ภายใน card ขยายเต็มแนวกว้าง
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ), // padding ภายในเล็กน้อยให้ดูหายใจ
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/women/2.jpg',
                  ),
                ),
                title: const Text(
                  "คนสวยข้ามภพ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text("skintigate@gmail.com"),
                trailing: const Icon(Icons.edit, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
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
              onPressed: () {},
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
              Get.toNamed("/login");
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
