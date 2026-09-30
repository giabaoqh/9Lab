import 'question.dart';

/// Class [QuizBrain] đóng vai trò là "Bộ não" quản lý toàn bộ dữ liệu và logic của bài thi trắc nghiệm.
/// Sử dụng nguyên lý Đóng gói (Encapsulation) trong OOP:
/// - Giữ các thuộc tính quan trọng dạng private (_) để tránh việc truy cập hoặc sửa đổi trái phép từ UI.
/// - Cung cấp các phương thức public để UI có thể giao tiếp và tương tác an toàn.
class QuizBrain {
  // Chỉ số theo dõi câu hỏi hiện tại (Private)
  int _questionNumber = 0;

  // Danh sách các câu hỏi trắc nghiệm (Private)
  final List<Question> _questionBank = [
    Question('Nước sôi ở nhiệt độ 100°C ở điều kiện áp suất tiêu chuẩn.', true),
    Question('Mặt Trời quay xung quanh Trái Đất.', false),
    Question('Trái Đất là hành tinh thứ 3 tính từ Mặt Trời trong Hệ Mặt Trời.', true),
    Question('Cá sấu có thể sống hoàn toàn dưới nước mà không cần ngoi lên thở.', false),
    Question('Việt Nam nằm ở khu vực Đông Nam Á.', true),
    Question('Số 2 là số nguyên tố duy nhất là số chẵn.', true),
    Question('ADN có cấu trúc dạng chuỗi xoắn đơn.', false),
    Question('Thành phố Hà Nội là thủ đô của nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.', true),
    Question('Tốc độ ánh sáng chậm hơn tốc độ truyền âm thanh.', false),
    Question('Pha màu xanh lam với màu vàng sẽ tạo ra màu xanh lá cây.', true),
    Question('Kim cương được cấu tạo chủ yếu từ nguyên tố Carbon (Cacbon).', true),
    Question('Dơi là một loài thuộc lớp Chim.', false),
  ];

  /// Lấy nội dung câu hỏi hiện tại
  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  /// Lấy đáp án đúng (true/false) của câu hỏi hiện tại
  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  /// Chuyển sang câu hỏi tiếp theo (nếu chưa phải câu cuối cùng)
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  /// Kiểm tra xem người dùng đã trả lời đến câu hỏi cuối cùng chưa
  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  /// Đặt lại chỉ số câu hỏi về câu đầu tiên (Reset bài làm)
  void reset() {
    _questionNumber = 0;
  }

  /// Lấy tổng số lượng câu hỏi trong danh sách
  int getTotalQuestions() {
    return _questionBank.length;
  }

  /// Lấy thứ tự câu hỏi hiện tại (bắt đầu từ 1) để hiển thị lên giao diện
  int getCurrentQuestionNumber() {
    return _questionNumber + 1;
  }
}
