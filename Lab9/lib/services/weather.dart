import 'package:flutter/foundation.dart';
import 'package:lab9/services/location.dart';
import 'package:lab9/services/networking.dart';

const String apiKey = 'e72ca729af228be065d56b4d17a41da3'; // OpenWeatherMap API Key
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

/// WeatherModel chứa API Key và các hàm xử lý dữ liệu thời tiết
class WeatherModel {
  /// Lấy thông tin thời tiết dựa trên tên thành phố
  Future<dynamic> getCityWeather(String cityName) async {
    String url = '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric&lang=vi';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  /// Lấy thông tin thời tiết dựa trên vị trí GPS hiện tại của người dùng
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    // Nếu không lấy được GPS (do từ chối quyền hoặc tắt GPS), fallback mặc định lấy theo Hà Nội
    if (location.latitude == null || location.longitude == null) {
      debugPrint('Không lấy được tọa độ GPS, tự động lấy thời tiết mặc định (Hà Nội).');
      return await getCityWeather('Hanoi');
    }

    String url =
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric&lang=vi';

    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();

    // Nếu API trả về null (lỗi mạng hoặc key hết hạn), thử fallback lấy theo Hà Nội
    if (weatherData == null) {
      debugPrint('API theo GPS thất bại, fallback sang Hà Nội.');
      return await getCityWeather('Hanoi');
    }

    return weatherData;
  }

  /// Ánh xạ mã điều kiện thời tiết (Condition Code) sang biểu tượng Icon thích hợp
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩️'; // Dông bão
    } else if (condition < 400) {
      return '🌧️'; // Mưa phun
    } else if (condition < 600) {
      return '☔'; // Mưa rào
    } else if (condition < 700) {
      return '❄️'; // Tuyết rơi
    } else if (condition < 800) {
      return '🌫️'; // Sương mù / Bụi
    } else if (condition == 800) {
      return '☀️'; // Trời quang
    } else if (condition <= 804) {
      return '☁️'; // Mây
    } else {
      return '🌡️';
    }
  }

  /// Đưa ra thông điệp / lời khuyên dựa trên nhiệt độ
  String getMessage(int temp) {
    if (temp > 30) {
      return 'Nắng nóng gay gắt 🍦 Hãy uống đủ nước & mang ô khi ra ngoài!';
    } else if (temp > 25) {
      return 'Thời tiết lý tưởng ☀️ Rất thích hợp cho các hoạt động ngoài trời!';
    } else if (temp > 18) {
      return 'Thời tiết mát mẻ 👕 Cực kỳ dễ chịu để dạo phố cùng bạn bè!';
    } else if (temp > 10) {
      return 'Thời tiết se lạnh 🧣 Nhớ mang theo áo khoác mỏng nhé!';
    } else {
      return 'Thời tiết rất lạnh ❄️ Giữ ấm cơ thể và thưởng thức trà nóng nhé!';
    }
  }
}
