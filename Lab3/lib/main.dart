import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceApp());
}

/// [DiceApp] là Root Widget của ứng dụng.
/// Sử dụng StatelessWidget vì cấu hình App chung (chủ đề, tiêu đề) không đổi.
class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const DicePage(),
    );
  }
}

/// [DicePage] là màn hình chính của ứng dụng.
/// Sử dụng [StatefulWidget] để quản lý và cập nhật lại trạng thái (số chấm xúc xắc).
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // Biến lưu trữ giá trị số điểm của viên xúc xắc bên trái (từ 1 đến 6)
  int leftDiceNumber = 1;

  // Biến lưu trữ giá trị số điểm của viên xúc xắc bên phải (từ 1 đến 6)
  int rightDiceNumber = 1;

  /// Hàm thực hiện lắc xúc xắc:
  /// Sử dụng `Random().nextInt(6)` tạo số ngẫu nhiên từ 0 -> 5, sau đó + 1 để được giá trị 1 -> 6.
  /// Bọc trong `setState()` để yêu cầu Flutter rebuild lại giao diện với giá trị mới.
  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Màu nền đỏ nổi bật đặc trưng của ứng dụng Dice
      backgroundColor: Colors.red.shade800,
      appBar: AppBar(
        title: const Text(
          'Dice',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        elevation: 4,
      ),
      body: Center(
        // Căn giữa toàn bộ nội dung theo chiều dọc và chiều ngang
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị 2 viên xúc xắc nằm ngang nhau
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Viên xúc xắc bên trái
                  // Sử dụng Expanded để 2 hình ảnh tự động chia đều chiều ngang màn hình
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: rollDice, // Nhấn vào hình ảnh để lắc xúc xắc
                        child: Image.asset('images/dice$leftDiceNumber.png'),
                      ),
                    ),
                  ),

                  // Viên xúc xắc bên phải
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: rollDice, // Nhấn vào hình ảnh để lắc xúc xắc
                        child: Image.asset('images/dice$rightDiceNumber.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40.0),

            // Hiển thị tổng điểm hiện tại
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Tổng điểm: ${leftDiceNumber + rightDiceNumber}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 30.0),

            // Nút bấm chính để lắc xúc xắc (ElevatedButton)
            ElevatedButton.icon(
              onPressed: rollDice,
              icon: const Icon(Icons.casino, size: 28),
              label: const Text(
                'LẮC XÚC XẮC',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red.shade900,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
