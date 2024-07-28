import 'package:flutter/material.dart';

class ExpertQuizPage extends StatefulWidget {
  @override
  _ExpertQuizPageState createState() => _ExpertQuizPageState();
}

class _ExpertQuizPageState extends State<ExpertQuizPage> {
  int _questionIndex = 0;
  int _correctAnswers = 0;
  String _feedback = '';

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'An AVL tree is a self-balancing binary search tree where the difference between heights of left and right subtrees cannot be more than:',
      'answers': [
        {'text': 'A) 1', 'isCorrect': true},
        {'text': 'B) 2', 'isCorrect': false},
        {'text': 'C) 3', 'isCorrect': false},
        {'text': 'D) 4', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'The time complexity of searching in an AVL tree is:',
      'answers': [
        {'text': 'A) O(1)', 'isCorrect': false},
        {'text': 'B) O(n)', 'isCorrect': false},
        {'text': 'C) O(log n)', 'isCorrect': true},
        {'text': 'D) O(n log n)', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'What is the height of an AVL tree with 7 nodes in the worst case?',
      'answers': [
        {'text': 'A) 2', 'isCorrect': false},
        {'text': 'B) 3', 'isCorrect': true},
        {'text': 'C) 4', 'isCorrect': false},
        {'text': 'D) 5', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Which of the following is a collision resolution technique in hashing?',
      'answers': [
        {'text': 'A) Chaining', 'isCorrect': true},
        {'text': 'B) Sorting', 'isCorrect': false},
        {'text': 'C) Partitioning', 'isCorrect': false},
        {'text': 'D) Dividing', 'isCorrect': false},
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

      if (_correctAnswers == _questions.length) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CongratulationsPage()),
        );
      }
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Expert Quiz'),
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
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
                'Congratulations, you have completed the Expert quiz!',
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
                  'Go to Home',
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
