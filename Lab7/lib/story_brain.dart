import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story(
      storyTitle:
          'Xe của bạn bị nổ lốp trên một con đường hẻm núi vắng vẻ, không có sóng điện thoại. Bạn quyết định đi vẫy xe nhờ. Một chiếc xe tải rỉ sét dừng lại. Người đàn ông mang nón rộng vành với đôi mắt vô hồn mở cửa cho bạn. Bạn có leo lên xe không?',
      choice1: 'Tôi sẽ leo lên. Cảm ơn vì đã giúp đỡ!',
      choice2: 'Thôi, tốt nhất là hỏi xem ông ta có thể giúp gọi cứu hộ không.',
    ),
    Story(
      storyTitle:
          'Ông ta gật đầu chậm rãi rồi bất ngờ rút ra một khẩu súng! Ông ta yêu cầu bạn đưa toàn bộ tiền mặt và chìa khóa xe.',
      choice1: 'Đưa ví và chìa khóa cho ông ta.',
      choice2: 'Bỏ chạy thật nhanh vào rừng cây ven đường.',
    ),
    Story(
      storyTitle:
          'Khi bạn leo lên xe, bạn nhận ra người lái xe mỉm cười gượng gạo và không nói lời nào. Trên băng ghế sau, bạn thấy một chiếc rìu dính đầy vệt đen bí ẩn.',
      choice1: 'Tôi thích rìu đấy! Cho tôi xem thử chiếc rìu được không?',
      choice2: 'Thôi chết! Đóng cửa xe lại và nhảy ra ngoài ngay lập tức!',
    ),
    Story(
      storyTitle:
          'Bạn đưa hết tiền và chìa khóa. Ông ta rồ ga lái xe đi mất, để bạn lại một mình trong đêm tối mù sương. Ít nhất bạn vẫn còn sống! (Kết thúc)',
      choice1: 'Bắt đầu lại (Restart)',
      choice2: '',
    ),
    Story(
      storyTitle:
          'Bạn nhảy ra khỏi xe khi xe đang chạy. Bạn bị thương nhẹ nhưng may mắn bò được vào bụi cây và trốn thoát an toàn. (Kết thúc)',
      choice1: 'Bắt đầu lại (Restart)',
      choice2: '',
    ),
    Story(
      storyTitle:
          'Bất ngờ người lái xe hóa ra là một người thợ rừng thân thiện đang trên đường đi làm. Ông ấy vui vẻ cho bạn quá giang đến trạm xăng gần nhất. (Kết thúc)',
      choice1: 'Bắt đầu lại (Restart)',
      choice2: '',
    ),
  ];

  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void nextStory(int choiceNumber) {
    if (_storyNumber == 0) {
      if (choiceNumber == 1) {
        _storyNumber = 2;
      } else if (choiceNumber == 2) {
        _storyNumber = 1;
      }
    } else if (_storyNumber == 1) {
      if (choiceNumber == 1) {
        _storyNumber = 3;
      } else if (choiceNumber == 2) {
        _storyNumber = 5;
      }
    } else if (_storyNumber == 2) {
      if (choiceNumber == 1) {
        _storyNumber = 5;
      } else if (choiceNumber == 2) {
        _storyNumber = 4;
      }
    } else if (_storyNumber == 3 || _storyNumber == 4 || _storyNumber == 5) {
      restart();
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    if (_storyNumber == 0 || _storyNumber == 1 || _storyNumber == 2) {
      return true;
    } else {
      return false;
    }
  }
}
