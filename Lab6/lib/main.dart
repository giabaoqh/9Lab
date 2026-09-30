import 'package:flutter/material.dart';
import 'quiz_brain.dart';

// Khởi tạo đối tượng bộ não QuizBrain để quản lý dữ liệu câu hỏi
QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler - Trắc nghiệm Đúng/Sai',
      // Giao diện nền tối (Dark Theme) chuẩn Material Design
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey.shade900,
      ),
      home: const Scaffold(
        backgroundColor: Colors.black12,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

/// Widget StatefulWidget để quản lý trạng thái cập nhật UI khi người dùng chọn đáp án
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Danh sách các Widget Icon (check xanh / close đỏ) hiển thị lịch sử trả lời ở phía dưới
  List<Widget> scoreKeeper = [];

  // Biến đếm số câu trả lời đúng
  int correctAnswersCount = 0;

  /// Hàm xử lý kiểm tra đáp án khi người dùng bấm nút Đúng hoặc Sai
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      // 1. So sánh đáp án người dùng chọn với đáp án đúng
      if (userPickedAnswer == correctAnswer) {
        // Nếu ĐÚNG: thêm Icon Check màu xanh lá
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
            size: 25.0,
          ),
        );
        correctAnswersCount++;
      } else {
        // Nếu SAI: thêm Icon Close màu đỏ
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
            size: 25.0,
          ),
        );
      }

      // 2. Kiểm tra nếu đã làm đến câu hỏi cuối cùng
      if (quizBrain.isFinished()) {
        // Hiển thị hộp thoại AlertDialog thông báo hoàn thành bài thi
        showDialog(
          context: context,
          barrierDismissible: false, // Bắt buộc người dùng phải bấm nút trên hộp thoại
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: const Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                  SizedBox(width: 10),
                  Text(
                    'Hoàn thành bài thi!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Text(
                'Chúc mừng bạn đã hoàn thành bài trắc nghiệm!\n\n'
                'Kết quả đạt được: $correctAnswersCount / ${quizBrain.getTotalQuestions()} câu đúng.',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Đóng hộp thoại AlertDialog
                    Navigator.of(context).pop();

                    // Cập nhật lại UI: Reset bài thi & xóa lịch sử icon điểm số
                    setState(() {
                      quizBrain.reset();
                      scoreKeeper.clear();
                      correctAnswersCount = 0;
                    });
                  },
                  child: const Text(
                    'Làm lại',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Nếu chưa hết câu hỏi -> Chuyển sang câu tiếp theo
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // ==========================================
        // 1. PHẦN CÂU HỎI Ở TRÊN (Chiếm tỉ lệ flex: 5)
        // ==========================================
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hiển thị tiến trình số câu hỏi (Ví dụ: Câu 1 / 12)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Câu ${quizBrain.getCurrentQuestionNumber()} / ${quizBrain.getTotalQuestions()}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  // Nội dung văn bản câu hỏi
                  Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ==========================================
        // 2. PHẦN NÚT BẤM "ĐÚNG" (Chiếm tỉ lệ flex: 1)
        // ==========================================
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Đúng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Người dùng chọn đáp án ĐÚNG (true)
                checkAnswer(true);
              },
            ),
          ),
        ),

        // ==========================================
        // 3. PHẦN NÚT BẤM "SAI" (Chiếm tỉ lệ flex: 1)
        // ==========================================
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Sai',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // Người dùng chọn đáp án SAI (false)
                checkAnswer(false);
              },
            ),
          ),
        ),

        // ==========================================
        // 4. PHẦN ĐIỂM SỐ BÊN DƯỚI (Hàng chứa danh sách các Icon kết quả)
        // ==========================================
        Container(
          height: 40.0,
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: scoreKeeper.isEmpty
                  ? [
                      const Text(
                        'Lịch sử trả lời: ',
                        style: TextStyle(color: Colors.white38, fontSize: 14),
                      )
                    ]
                  : scoreKeeper,
            ),
          ),
        ),
      ],
    );
  }
}
