import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:otrujja/Helpers/utils.dart';
import 'package:otrujja/Screens/home_screen.dart';

class QuizResult extends StatelessWidget {
  final finalScore;
  final questions;
  final userAnswers;
  const QuizResult(
      {Key? key, this.finalScore, this.questions, this.userAnswers})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F3ED),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: SlideInUp(
                child: Swiper(
                  pagination: SwiperPagination(
                    builder: SwiperPagination.fraction,
                  ),
                  curve: Curves.decelerate,
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, i) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffF6DCC1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FadeInUp(
                              child: Text(
                                '${questions[i]['question']}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Color(0xff27407F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'الإجابة الصحيحة هي : ${questions[i]['answers'][Utils.reverseAlphaNumeric(questions[i]['correct_answer'].toString().toUpperCase()) - 1]}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeInUp(
                          delay: Duration(seconds: 1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'إجابتك كانت : ${userAnswers[i]}',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: questions[i]['answers'][
                                              Utils.reverseAlphaNumeric(
                                                      questions[i]
                                                              ['correct_answer']
                                                          .toString()
                                                          .toUpperCase()) -
                                                  1] ==
                                          userAnswers[i]
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.width / 10,
            child: SafeArea(
              child: Container(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'تقييمك النهائي ',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff27407F),
                        ),
                      ),
                      TextSpan(
                        text: '$finalScore',
                        style:
                            TextStyle(color: _finalScoreColor(), fontSize: 30),
                      ),
                      TextSpan(
                        text: '/10',
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff27407F),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                      (route) => false);
                },
                child: Text(
                  'أكمل',
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color? _finalScoreColor() {
    print('object');
    if (finalScore <= 5) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  Container buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [Color(0xff2a1434), Color(0xff160d20), Color(0xff142332)],
        ),
      ),
    );
  }
}
