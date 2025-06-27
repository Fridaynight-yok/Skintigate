import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          // Profile picture & name
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/women/2.jpg',
              ),
            ),
            title: Text(
              "Your name",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("yourname@gmail.com"),
            trailing: Icon(Icons.edit, color: Colors.grey),
          ),
          Divider(),
          // Fields
          ListTile(title: Text("Name"), onTap: () {}),
          Divider(height: 1, color: const Color.fromARGB(255, 189, 188, 188)),
          ListTile(title: Text("Email"), onTap: () {}),
          Divider(height: 1),
          ListTile(title: Text("Phone"), onTap: () {}),
          Divider(height: 1, color: const Color.fromARGB(255, 189, 188, 188)),
          ListTile(title: Text("Address"), onTap: () {}),
          SizedBox(height: 24),
          // Save Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0B8F64),
                shape: StadiumBorder(),
                minimumSize: Size(double.infinity, 48),
              ),
              onPressed: () {},
              child: Text(
                "Save Changes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Logout
          TextButton(
            onPressed: () {},
            child: Text("Log out", style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
