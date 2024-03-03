import 'package:flutter/material.dart';
import 'package:frivia_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frivia Application',
      theme: ThemeData(
        fontFamily: "BadScript",
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
      ),
      home: const Stack(
        children: [
          Background(),
          HomePage(),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/bg.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
