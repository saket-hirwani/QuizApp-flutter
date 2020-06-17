import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizzler/quiz_brain.dart';
//import 'package:quizzler/Questions.dart';

QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
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

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scorekeeper = [];
  void checkAnswer(bool userPickedAnswer){
    bool CorrectAnswer = quizBrain.getCorrectAnswer();
    setState(() {

//TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If true, execute Part A, B, C, D.
      if(quizBrain.isFinished()==true) {
        //TODO: Step 4 Part A - show an alert using rFlutter_alert (remember to read the docs for the package!)
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        //HINT! Step 4 Part B is in the quiz_brain.dart
        //TODO: Step 4 Part C - reset the questionNumber,
        quizBrain.reset();
        //TODO: Step 4 Part D - empty out the scoreKeeper.
        scorekeeper = [];
      }
      else {
        //TODO: Step 5 - If we've not reached the end, ELSE do the answer checking steps below 👇
        if (userPickedAnswer == CorrectAnswer) {
          scorekeeper.add(
              Icon(Icons.check, color: Colors.green,)
          );
        } else {
          scorekeeper.add(
              Icon(Icons.close, color: Colors.red,)
          );
        }
        quizBrain.nextQuestion();
      }
    });
  }
//  List<String> Questions = ['You can lead a cow down stairs but not up stairs.',
////    'Approximately one quarter of human bones are in the feet.',
////    'A slug\'s blood is green.'
////  ];
////  List<bool> Answers = [false,
////  true,
////  true];
////  int QuestionNumber = 0;
////  Question q1 = Question(q: 'You can lead a cow down stairs but not up stairs.',a: false);

  ////////////////////////////////////Abstraion/////////////////////////////////////////
//  List<Question> QuestionBank = [
//    Question(q: 'You can lead a cow down stairs but not up stairs.',a: false),
//    Question(q: 'Approximately one quarter of human bones are in the feet.',a: true),
//    Question(q: 'A slug\'s blood is green.',a: true),
//];
//  int QuestionNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
