import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              "To enter a profile,\nyou have to log in",
              style: TextStyle(
                fontSize: 23,
                color: Color.fromRGBO(32, 76, 75, 1),
              ),
            ),
            SizedBox(height: 18),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20),
                //   borderSide: BorderSide(color: Color.fromRGBO(32, 76, 75, 1)),
                // ),
                hintText: "email",
              ),
            ),
            SizedBox(height: 18),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(20),
                //   borderSide: BorderSide(color: Color.fromRGBO(32, 76, 75, 1)),
                // ),
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
                    "Login",
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 18),
            Text("Don't have an account?", style: TextStyle(fontSize: 15)),
            Text(
              "Sign Up",
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
