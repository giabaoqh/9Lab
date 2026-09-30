import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MiCardApp());
}

/// Widget gốc của ứng dụng MiCard
class MiCardApp extends StatelessWidget {
  const MiCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiCard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
      ),
      home: const MiCardHomePage(),
    );
  }
}

/// Màn hình chính hiển thị danh thiếp kỹ thuật số
class MiCardHomePage extends StatelessWidget {
  const MiCardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Scaffold với màu nền đỏ cam chủ đạo
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      // SafeArea đảm bảo nội dung không bị tai thỏ (notch) hoặc thanh điều hướng che khuất
      body: SafeArea(
        // SingleChildScrollView chống lỗi tràn màn hình (pixel overflow) trên màn hình nhỏ hoặc khi xoay ngang
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                // Căn giữa toàn bộ nội dung theo chiều dọc
                mainAxisAlignment: MainAxisAlignment.center,
                // Căn giữa các widget con theo chiều ngang
                crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // 1. Ảnh đại diện hình tròn (CircleAvatar)
                const CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('images/avatar.png'),
                ),

                const SizedBox(height: 12.0),

                // 2. Tên cá nhân - Font chữ viết tay nghệ thuật Pacifico
                Text(
                  'ThinkPad E14',
                  style: GoogleFonts.pacifico(
                    fontSize: 36.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6.0),

                // 3. Chức danh / Nghề nghiệp - Chữ in hoa thanh mảnh với khoảng cách chữ rộng
                Text(
                  'FLUTTER DEVELOPER',
                  style: GoogleFonts.sourceSans3(
                    color: Colors.orange.shade100,
                    fontSize: 18.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                // 4. Đường phân cách (Divider) mỏng, thanh lịch
                SizedBox(
                  height: 25.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.orange.shade100.withValues(alpha: 0.6),
                    thickness: 1.0,
                  ),
                ),

                const SizedBox(height: 10.0),

                // 5. Thẻ liên hệ 1: Số điện thoại
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  elevation: 4.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.deepOrange,
                      size: 26.0,
                    ),
                    title: Text(
                      '+84 394 281 107',
                      style: GoogleFonts.sourceSans3(
                        color: Colors.deepOrange.shade900,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // 6. Thẻ liên hệ 2: Email
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  elevation: 4.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.deepOrange,
                      size: 26.0,
                    ),
                    title: Text(
                      'flutter.developer@gmail.com',
                      style: GoogleFonts.sourceSans3(
                        color: Colors.deepOrange.shade900,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
