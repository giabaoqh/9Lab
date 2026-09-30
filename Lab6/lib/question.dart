/// Class đại diện cho một câu hỏi trắc nghiệm trong ứng dụng Quizzler.
/// Gồm 2 thuộc tính:
/// - [questionText]: Nội dung câu hỏi dạng văn bản.
/// - [questionAnswer]: Đáp án đúng của câu hỏi (true = Đúng, false = Sai).
class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}
