import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * .16),
            Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 23,
                color: Color.fromRGBO(32, 76, 75, 1),
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                hintText: "name",
              ),
            ),
            SizedBox(height: 18),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                hintText: "email",
              ),
            ),
            SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 1)),
                ),
                hintText: "password",
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
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text("Already have an account?", style: TextStyle(fontSize: 15)),
            Text(
              "Log in",
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
