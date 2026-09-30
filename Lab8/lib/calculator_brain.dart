import 'dart:math';

/// Enum phân loại Giới tính
enum Gender { male, female }

/// Class CalculatorBrain xử lý logic tính toán chỉ số BMI và đưa ra kết quả phân loại, lời khuyên.
class CalculatorBrain {
  final int height; // Chiều cao (cm)
  final int weight; // Cân nặng (kg)

  late double _bmi;

  CalculatorBrain({
    required this.height,
    required this.weight,
  }) {
    // Công thức tính BMI: weight (kg) / [height (m)]^2
    _bmi = weight / pow(height / 100, 2);
  }

  /// Trả về chuỗi giá trị BMI làm tròn 1 chữ số thập phân (VD: "22.5")
  String calculateBMI() {
    return _bmi.toStringAsFixed(1);
  }

  /// Trả về kết quả phân loại thể trạng
  String getResult() {
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  /// Trả về nhận xét / lời khuyên chi tiết cho người dùng
  String getInterpretation() {
    if (_bmi >= 25) {
      return 'Bạn đang có trọng lượng cơ thể cao hơn bình thường. Hãy cố gắng tập thể dục nhiều hơn nhé!';
    } else if (_bmi >= 18.5) {
      return 'Bạn đang có một trọng lượng cơ thể tuyệt vời và cân đối. Hãy tiếp tục duy trì!';
    } else {
      return 'Trọng lượng cơ thể của bạn đang thấp hơn bình thường. Bạn nên ăn uống đầy đủ dinh dưỡng hơn!';
    }
  }
}
