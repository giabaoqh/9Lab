import 'package:flutter/material.dart';

void main() {
  // Khởi chạy ứng dụng IAmRichApp
  runApp(const IAmRichApp());
}

/// Widget gốc của ứng dụng
class IAmRichApp extends StatelessWidget {
  const IAmRichApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Tắt biểu tượng "DEBUG" ở góc trên bên phải
      debugShowCheckedModeBanner: false,
      title: 'I Am Rich',
      home: HomeScreen(),
    );
  }
}

/// Màn hình chính của ứng dụng
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền tối (Dark blue grey) làm nổi bật viên kim cương
      backgroundColor: const Color(0xFF263238),
      appBar: AppBar(
        // Tiêu đề ứng dụng
        title: const Text(
          'I Am Rich',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        // Căn giữa tiêu đề ở thanh AppBar
        centerTitle: true,
        // Màu sắc nổi bật (Màu cam hổ phách / amber đậm)
        backgroundColor: Colors.amber[800],
        elevation: 4.0,
      ),
      // Căn giữa hình ảnh viên kim cương ở giữa màn hình
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'images/diamond.png',
            width: 320,
            height: 320,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
