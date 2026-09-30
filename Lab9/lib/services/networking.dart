import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Class NetworkHelper chịu trách nhiệm gửi HTTP request và parse dữ liệu JSON nhận được.
class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  /// Gửi HTTP GET request tới URL được cung cấp và parse kết quả JSON.
  /// Trả về `dynamic` (Map dữ liệu JSON) hoặc `null` nếu có lỗi xảy ra.
  Future<dynamic> getData() async {
    try {
      Uri uri = Uri.parse(url);
      http.Response response = await http.get(uri).timeout(
        const Duration(seconds: 12),
      );

      // Mã trạng thái HTTP 200 nghĩa là yêu cầu thành công
      if (response.statusCode == 200) {
        String data = response.body;
        // Giải mã chuỗi JSON thành đối tượng Map/List trong Dart
        dynamic decodedData = jsonDecode(data);
        return decodedData;
      } else {
        debugPrint('HTTP Error Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Lỗi kết nối mạng (Network Error): $e');
      return null;
    }
  }
}
