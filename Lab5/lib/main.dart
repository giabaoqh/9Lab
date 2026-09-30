import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const XylophoneApp());
}

/// Widget gốc của ứng dụng Xylophone
class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: const SafeArea(
          child: XylophonePage(),
        ),
      ),
    );
  }
}

/// Màn hình chính chứa 7 phím đàn Xylophone
class XylophonePage extends StatelessWidget {
  const XylophonePage({super.key});

  /// Hàm tái sử dụng để phát âm thanh nốt nhạc tương ứng
  /// [soundNumber] nhận vào số từ 1 đến 7 tương ứng với tệp note1.wav -> note7.wav
  void playSound(int soundNumber) {
    final player = AudioPlayer();
    // Khởi tạo và phát tệp âm thanh từ thư mục assets
    player.play(AssetSource('note$soundNumber.wav'));
  }

  /// Hàm Helper dùng để khởi tạo từng phím đàn (Key)
  /// Giúp tối ưu mã nguồn, giảm lặp lại code theo nguyên tắc DRY (Don't Repeat Yourself)
  Widget buildKey({
    required Color color,
    required int soundNumber,
    required String noteName,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            // Tùy chỉnh bo tròn 12px cho góc phím đàn thêm mềm mại & hiện đại
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
          ),
          onPressed: () {
            playSound(soundNumber);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  noteName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.music_note,
                  color: Colors.white70,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Kéo dãn phím đàn chiếm trọn chiều rộng của Column
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Phím 1: Đỏ - Nốt C (Đô)
        buildKey(color: Colors.red, soundNumber: 1, noteName: 'C - Đô'),

        // Phím 2: Cam - Nốt D (Rê)
        buildKey(color: Colors.orange, soundNumber: 2, noteName: 'D - Rê'),

        // Phím 3: Vàng - Nốt E (Mi)
        buildKey(color: Colors.yellow.shade700, soundNumber: 3, noteName: 'E - Mi'),

        // Phím 4: Lục - Nốt F (Pha)
        buildKey(color: Colors.green, soundNumber: 4, noteName: 'F - Pha'),

        // Phím 5: Lam - Nốt G (Sol)
        buildKey(color: Colors.teal, soundNumber: 5, noteName: 'G - Sol'),

        // Phím 6: Chàm - Nốt A (La)
        buildKey(color: Colors.blue, soundNumber: 6, noteName: 'A - La'),

        // Phím 7: Tím - Nốt B (Xì)
        buildKey(color: Colors.purple, soundNumber: 7, noteName: 'B - Xì'),
      ],
    );
  }
}
