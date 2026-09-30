import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BallPage(),
    ),
  );
}

/// Widget chứa toàn bộ khung giao diện chính (Scaffold) của ứng dụng Magic 8 Ball
class BallPage extends StatelessWidget {
  const BallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text(
          'Ask Me Anything',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        elevation: 4,
      ),
      body: const Ball(),
    );
  }
}

/// StatefulWidget quản lý trạng thái biến đổi hình ảnh quả cầu tiên tri
class Ball extends StatefulWidget {
  const Ball({super.key});

  @override
  State<Ball> createState() => _BallState();
}

class _BallState extends State<Ball> {
  // Khai báo biến lưu trữ số thứ tự hình ảnh hiện tại (từ 1 đến 5)
  int ballNumber = 1;

  // Hàm xử lý tạo số ngẫu nhiên từ 1 đến 5 và cập nhật giao diện
  void rollBall() {
    setState(() {
      // Random().nextInt(5) tạo số ngẫu nhiên từ 0 đến 4.
      // Cộng 1 để nhận kết quả từ 1 đến 5 tương ứng với ball1.png -> ball5.png
      ballNumber = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Nút bấm chứa hình ảnh quả cầu tiên tri
          Expanded(
            child: TextButton(
              onPressed: () {
                rollBall();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('images/ball$ballNumber.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
