import 'package:flutter/material.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/image/scan_page_.png",
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
        ),
        Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [Text("Please choose either\ninput or upload photo")],
          ),
        ),
      ],
    );
  }
}
