import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

/// Class Location chịu trách nhiệm truy xuất tọa độ GPS của thiết bị.
/// Sử dụng package `geolocator` để xin quyền và lấy kinh độ (longitude), vĩ độ (latitude).
class Location {
  double? latitude;
  double? longitude;

  /// Lấy vị trí GPS hiện tại của thiết bị với đầy đủ kiểm tra dịch vụ & quyền truy cập.
  Future<void> getCurrentLocation() async {
    try {
      // 1. Kiểm tra xem Dịch vụ Vị trí (GPS) trên thiết bị có đang bật hay không
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Dịch vụ vị trí (GPS) đang bị tắt trên thiết bị.');
        return;
      }

      // 2. Kiểm tra quyền truy cập vị trí của ứng dụng
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Nếu quyền chưa được cấp, tiến hành yêu cầu người dùng cấp quyền
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Người dùng từ chối cấp quyền truy cập vị trí.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Quyền truy cập bị từ chối vĩnh viễn (người dùng chọn "Don't ask again")
        debugPrint('Quyền vị trí bị từ chối vĩnh viễn trong cài đặt thiết bị.');
        return;
      }

      // 3. Khi đã có đủ quyền, tiến hành lấy tọa độ GPS hiện tại
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;
      debugPrint('Tọa độ lấy thành công: Lat $latitude, Lon $longitude');
    } catch (e) {
      debugPrint('Lỗi khi lấy vị trí GPS: $e');
    }
  }
}
