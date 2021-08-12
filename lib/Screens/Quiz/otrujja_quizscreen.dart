import 'package:animate_do/animate_do.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otrujja/Helpers/utils.dart';
import 'package:otrujja/Screens/Results/practice_result.dart';

class OtrujjaQuiz extends StatefulWidget {
  final quiz;
  const OtrujjaQuiz({Key? key, this.quiz}) : super(key: key);
  @override
  _OtrujjaQuizState createState() => _OtrujjaQuizState();
}

class _OtrujjaQuizState extends State<OtrujjaQuiz> {
  int _questionNumber = 0;
  int _score = 0;
  List<String> _userAnswers = [];
  final _countDown = CountDownController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                child: SvgPicture.asset('assets/hand.svg',
                    semanticsLabel: 'A red up arrow'),
              ),
              buildCounter(),
            ],
          ),
          buildQuestion(context),
          Divider(),
          buildAnswers(context)
        ],
      ),
    );
  }

  Positioned buildAnswers(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      left: 0,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.quiz[_questionNumber]['answers'].length,
        itemBuilder: (_, index) => ListTile(
          onTap: () => _checkAnswer(
              widget.quiz[_questionNumber]['answers'][index], index),
          title: Text(
            '${widget.quiz[_questionNumber]['answers'][index]}',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff8B91BC),
            ),
          ),
        ),
      ),
    );
  }

  Align buildCounter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: CircularCountDownTimer(
            duration: 60,
            initialDuration: 0,
            controller: _countDown,
            width: 100,
            height: 100,
            ringColor: Colors.transparent,
            fillColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
                fontSize: 24.0,
                color: Colors.orange,
                fontWeight: FontWeight.bold),
            textFormat: CountdownTextFormat.MM_SS,
            isReverse: true,
            isTimerTextShown: true,
            autoStart: true,
            onComplete: () {
              setState(
                () {
                  if (_questionNumber < 9) {
                    _getNextQuestion();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Positioned buildQuestion(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: FadeInUp(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'سوال ${_questionNumber + 1}: ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontSize: 19,
                      color: Color(0xff6F76A0),
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffFAEDDD),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.quiz[_questionNumber]['question']}',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xffEAB688),
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkAnswer(String answer, int? answerIndex) {
    print(answerIndex);
    if (answerIndex != null) {
      if (widget.quiz[_questionNumber]['correct_answer']
              .toString()
              .toUpperCase() ==
          Utils.alphaNumeric(answerIndex + 1)) {
        _score++;
      }
      _userAnswers.add(answer);
      if (_questionNumber != 9) {
        _getNextQuestion();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => QuizResult(
              finalScore: _score,
              questions: widget.quiz,
              userAnswers: _userAnswers,
            ),
          ),
        );
      }
    }
  }

  _getNextQuestion() {
    setState(() => _questionNumber++);
    _countDown.restart();
  }
}
