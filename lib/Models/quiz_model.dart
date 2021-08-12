class QuizModel {
  String? _question;
  String? _correctAnswer;
  List<String>? _answers;

  QuizModel(
      {required String question,
      required String correctAnswer,
      required List<String> answers}) {
    this._question = question;
    this._correctAnswer = correctAnswer;
    this._answers = answers;
  }

  String get question => _question!;
  set question(String question) => _question = question;
  String get correctAnswer => _correctAnswer!;
  set correctAnswer(String correctAnswer) => _correctAnswer = correctAnswer;
  List<String> get answers => _answers!;
  set answers(List<String> answers) => _answers = answers;

  QuizModel.fromJson(Map<String, dynamic> json) {
    _question = json['question'];
    _correctAnswer = json['correct_answer'];
    _answers = json['answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this._question;
    data['correct_answer'] = this._correctAnswer;
    data['answers'] = this._answers;
    return data;
  }
}
