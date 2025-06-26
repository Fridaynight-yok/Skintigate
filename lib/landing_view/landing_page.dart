import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/first_page_.png",
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                OutlinedText(
                  text: Text(
                    "One touch to unlock\nyour perfect skin\n match",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: Color.fromRGBO(32, 76, 62, 1),
                    ),
                  ),
                  strokes: [OutlinedTextStroke(color: Colors.white, width: 2)],
                ),

                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 255, 255, .8),
                    side: BorderSide(color: Color.fromRGBO(10, 107, 75, 0.698)),
                    elevation: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Search Product",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(35, 96, 77, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(152, 215, 194, 0.6),
                    side: BorderSide(color: Color.fromRGBO(10, 107, 75, 0.698)),
                    elevation: 10,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Scan Ingredients",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(35, 96, 77, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(13, 152, 106, 1),
                    elevation: 20,
                  ),
                  child: SizedBox(
                    height: 55,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "My Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(253, 254, 254, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
