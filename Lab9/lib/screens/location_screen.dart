import 'package:flutter/material.dart';
import 'package:lab9/screens/city_screen.dart';
import 'package:lab9/services/weather.dart';

/// LocationScreen là màn hình chính hiển thị toàn bộ chi tiết thời tiết.
class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  const LocationScreen({super.key, this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature = 0;
  int feelsLike = 0;
  int minTemp = 0;
  int maxTemp = 0;
  int humidity = 0;
  double windSpeed = 0.0;
  int pressure = 0;
  String weatherIcon = '';
  String weatherMessage = '';
  String weatherDescription = '';
  String cityName = '';
  String countryCode = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  /// Hàm bóc tách dữ liệu JSON từ API và cập nhật State của màn hình
  void updateUI(dynamic weatherData) {
    setState(() {
      isLoading = false;

      // Xử lý ngoại lệ nếu weatherData bị null (không có mạng, sai tên thành phố,...)
      if (weatherData == null) {
        temperature = 0;
        feelsLike = 0;
        minTemp = 0;
        maxTemp = 0;
        humidity = 0;
        windSpeed = 0.0;
        pressure = 0;
        weatherIcon = '⚠️';
        weatherMessage = 'Không thể lấy dữ liệu thời tiết. Vui lòng kiểm tra lại mạng hoặc tên thành phố!';
        weatherDescription = 'Lỗi kết nối';
        cityName = 'Không rõ';
        countryCode = '';
        return;
      }

      // 1. Trích xuất nhiệt độ và làm tròn nguyên
      double temp = (weatherData['main']['temp'] as num).toDouble();
      temperature = temp.round();

      double feels = (weatherData['main']['feels_like'] as num).toDouble();
      feelsLike = feels.round();

      double minT = (weatherData['main']['temp_min'] as num).toDouble();
      minTemp = minT.round();

      double maxT = (weatherData['main']['temp_max'] as num).toDouble();
      maxTemp = maxT.round();

      // 2. Trích xuất độ ẩm, áp suất, tốc độ gió
      humidity = weatherData['main']['humidity'] ?? 0;
      pressure = weatherData['main']['pressure'] ?? 0;
      windSpeed = (weatherData['wind']['speed'] as num).toDouble();

      // 3. Trích xuất mã điều kiện thời tiết (Condition Code) và mô tả
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
      weatherDescription = weatherData['weather'][0]['description'] ?? '';
      // Viết hoa chữ cái đầu mô tả
      if (weatherDescription.isNotEmpty) {
        weatherDescription = weatherDescription[0].toUpperCase() +
            weatherDescription.substring(1);
      }

      // 4. Trích xuất tên thành phố và quốc gia
      cityName = weatherData['name'] ?? 'Chưa rõ';
      countryCode = weatherData['sys']?['country'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.cyanAccent,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() => isLoading = true);
                    var weatherData = await weatherModel.getLocationWeather();
                    updateUI(weatherData);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // 1. Thanh điều hướng top bar (GPS Refresh & Search City)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Nút lấy lại vị trí hiện tại GPS
                              IconButton(
                                onPressed: () async {
                                  setState(() => isLoading = true);
                                  var weatherData =
                                      await weatherModel.getLocationWeather();
                                  updateUI(weatherData);
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.near_me,
                                    size: 24.0,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                tooltip: 'Vị trí hiện tại GPS',
                              ),

                              // Nút chuyển sang màn hình tìm kiếm theo thành phố
                              IconButton(
                                onPressed: () async {
                                  var typedName = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const CityScreen();
                                      },
                                    ),
                                  );

                                  if (typedName != null &&
                                      typedName.toString().isNotEmpty) {
                                    setState(() => isLoading = true);
                                    var weatherData = await weatherModel
                                        .getCityWeather(typedName.toString());
                                    updateUI(weatherData);
                                  }
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white24,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.search,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                                tooltip: 'Tìm thành phố',
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          // 2. Hiển thị vị trí thành phố + Quốc gia
                          Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.redAccent,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      countryCode.isNotEmpty
                                          ? '$cityName, $countryCode'
                                          : cityName,
                                      style: const TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    weatherDescription,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.cyanAccent,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // 3. Khối hiển thị Nhiệt độ chính & Icon
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  weatherIcon,
                                  style: const TextStyle(fontSize: 80),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$temperature',
                                      style: const TextStyle(
                                        fontSize: 84.0,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        height: 1.0,
                                      ),
                                    ),
                                    const Text(
                                      '°C',
                                      style: TextStyle(
                                        fontSize: 36.0,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.cyanAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Cảm giác như: $feelsLike°C',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // 4. Khối Thông điệp & Lời khuyên
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.cyan.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.cyanAccent.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline,
                                  color: Colors.amberAccent,
                                  size: 28,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    weatherMessage,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // 5. Khối Thẻ Chỉ Số Chi Tiết (Humidity, Wind Speed, Min Temp, Max Temp)
                          const Text(
                            'Chi Tiết Thời Tiết',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 14),

                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 14,
                            childAspectRatio: 1.45,
                            children: [
                              _buildDetailCard(
                                icon: Icons.water_drop,
                                iconColor: Colors.blueAccent,
                                label: 'Độ Ẩm',
                                value: '$humidity%',
                              ),
                              _buildDetailCard(
                                icon: Icons.air,
                                iconColor: Colors.cyanAccent,
                                label: 'Tốc Độ Gió',
                                value: '$windSpeed m/s',
                              ),
                              _buildDetailCard(
                                icon: Icons.thermostat_outlined,
                                iconColor: Colors.lightBlue,
                                label: 'Nhiệt Độ Thấp Nhất',
                                value: '$minTemp°C',
                              ),
                              _buildDetailCard(
                                icon: Icons.thermostat,
                                iconColor: Colors.deepOrangeAccent,
                                label: 'Nhiệt Độ Cao Nhất',
                                value: '$maxTemp°C',
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// Helper widget dựng thẻ chi tiết chỉ số thời tiết
  Widget _buildDetailCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
