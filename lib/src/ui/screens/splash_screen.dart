import 'package:flutter/material.dart';
import 'package:omni_bridge_assignment/src/core/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: Image(
              width: size.width * 0.65,
              height: size.width * 0.65,
              fit: BoxFit.contain,
              image: AssetImage(Constants.petsImg))),
    );
  }
}
