import 'package:flutter/material.dart';
import 'trangchu.dart'; // Import trangchu.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(), // ← Sử dụng TrangChu làm màn hình chính
    );
  }
}
