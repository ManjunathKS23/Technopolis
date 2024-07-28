import 'package:flutter/material.dart';

class IntermediateQuizPage extends StatefulWidget {
  @override
  _IntermediateQuizPageState createState() => _IntermediateQuizPageState();
}

class _IntermediateQuizPageState extends State<IntermediateQuizPage> {
  int _questionIndex = 0;
  int _correctAnswers = 0;
  String _feedback = '';

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the time complexity of accessing the nth element in a singly linked list?',
      'answers': [
        {'text': 'A) O(1)', 'isCorrect': false},
        {'text': 'B) O(n)', 'isCorrect': true},
        {'text': 'C) O(log n)', 'isCorrect': false},
        {'text': 'D) O(n log n)', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'In a doubly linked list, which pointer is used to traverse backwards?',
      'answers': [
        {'text': 'A) next pointer', 'isCorrect': false},
        {'text': 'B) prev pointer', 'isCorrect': true},
        {'text': 'C) head pointer', 'isCorrect': false},
        {'text': 'D) tail pointer', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Which traversal method of a BST yields the nodes in ascending order?',
      'answers': [
        {'text': 'A) Pre-order', 'isCorrect': false},
        {'text': 'B) In-order', 'isCorrect': true},
        {'text': 'C) Post-order', 'isCorrect': false},
        {'text': 'D) Level-order', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'What is the maximum number of children a node in a binary search tree can have?',
      'answers': [
        {'text': 'A) 1', 'isCorrect': false},
        {'text': 'B) 2', 'isCorrect': true},
        {'text': 'C) 3', 'isCorrect': false},
        {'text': 'D) 4', 'isCorrect': false},
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Intermediate Quiz'),
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
                'Congratulations, now you can go to Expert!',
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
                  'Go to Expert',
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
        title: Text('Expert Level'),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Text(
          'Welcome to the Expert level!',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
