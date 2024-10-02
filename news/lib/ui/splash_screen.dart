import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/ui/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    final titleTextStyle = GoogleFonts.anton(
      letterSpacing: 6,
      color: Colors.grey.shade700,
      fontSize: 30,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
        body: Stack(children: [
      Image.asset("assets/images/splash_pic.jpg",
          fit: BoxFit.cover, height: height, width: width),
      Container(
        // color: Colors.black.withOpacity(0.2), // semi-transparent overlay
        height: height,
        width: width,
      ),
      Positioned(
        top: width * 0.12,
        left: 0,
        right: 0,
        child: Center(
          child: Text("News World", style: titleTextStyle),
        ),
      ),
      Positioned(
        bottom: height * 0.1, // Adjust as needed
        left: 0,
        right: 0,
        child: const Column(
          children: [
            SpinKitChasingDots(
              color: Colors.blue,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              "Loading...",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    ]));
  }
}
