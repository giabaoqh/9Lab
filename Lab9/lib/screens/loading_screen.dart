import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab9/screens/location_screen.dart';
import 'package:lab9/services/weather.dart';

/// LoadingScreen là màn hình chờ khi khởi chạy ứng dụng.
/// Thực hiện nhiệm vụ xin quyền GPS và lấy thông tin thời tiết hiện tại
/// trước khi chuyển hướng sang LocationScreen.
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  /// Lấy dữ liệu thời tiết dựa trên vị trí GPS và chuyển sang LocationScreen
  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    if (!mounted) return;

    // Chuyển sang màn hình hiển thị thời tiết LocationScreen và chuyển weatherData sang
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.indigo.shade900,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingCircle(
                color: Colors.cyanAccent,
                size: 80.0,
              ),
              const SizedBox(height: 30),
              Text(
                'Đang tải dữ liệu thời tiết...',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Đang truy xuất GPS và kết nối OpenWeatherMap',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
