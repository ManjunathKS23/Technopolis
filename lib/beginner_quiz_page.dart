import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionIndex = 0;
  int _correctAnswers = 0;
  String _feedback = '';

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Stack is a ______ data structure.',
      'answers': [
        {'text': 'A. Linear', 'isCorrect': true},
        {'text': 'B. Non-Linear', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Stack works on ________ principle.',
      'answers': [
        {'text': 'A. LILO', 'isCorrect': false},
        {'text': 'B. FIFO', 'isCorrect': false},
        {'text': 'C. LIFO', 'isCorrect': true},
        {'text': 'D. FILO', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Which of the following data structures is used to implement recursion?',
      'answers': [
        {'text': 'A. Queue', 'isCorrect': false},
        {'text': 'B. Stack', 'isCorrect': true},
        {'text': 'C. Linked List', 'isCorrect': false},
        {'text': 'D. Tree', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Which of the following is a non-linear data structure?',
      'answers': [
        {'text': 'A. Array', 'isCorrect': false},
        {'text': 'B. Linked List', 'isCorrect': false},
        {'text': 'C. Stack', 'isCorrect': false},
        {'text': 'D. Tree', 'isCorrect': true},
      ],
    },
  ];

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _correctAnswers++;
        _feedback = _questionIndex == _questions.length - 1
            ? 'You got it.'
            : 'Great Job. Keep Going';
      } else {
        _feedback = 'Oops! Try again.';
      }
    });

    if (_correctAnswers == _questions.length) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CongratulationsPage()),
      );
    }
  }

  void _nextQuestion() {
    setState(() {
      _feedback = '';
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        _questionIndex = 0;
        _correctAnswers = 0; // Reset for another attempt
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = (_questionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
              ),
            ),
            Spacer(), // Add Spacer before the question to push it to the center
            Text(
              _questions[_questionIndex]['questionText'] as String,
              style: TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: (_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                  .map((answer) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    _answerQuestion(answer['isCorrect'] as bool);
                  },
                  child: Text(
                    answer['text'] as String,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              _feedback,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            if (_feedback.isNotEmpty && _correctAnswers < _questions.length)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: _nextQuestion,
                child: Text(
                  _feedback.contains('Great Job') || _feedback == 'You got it.'
                      ? 'Next Question'
                      : 'Try Again',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            Spacer(), // Add Spacer after the buttons to push the content upwards
          ],
        ),
      ),
    );
  }
}

class CongratulationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congratulations'),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations, now you can go to Intermediate!',
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text(
                  'Go to Intermediate',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Replace with your actual IntermediatePage implementation
class IntermediatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intermediate Level'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Text(
          'Welcome to the Intermediate level!',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
