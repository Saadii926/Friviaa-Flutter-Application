import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxquestions;
  List? questions;
  int currentQuestion = 0;
  int correctCount = 0;
  final String levels;

  BuildContext context;
  GamePageProvider({
    required this.context,
    required this.levels,
    required this.maxquestions,
  }) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    getQuestionFromUrl();
  }

  Future<void> getQuestionFromUrl() async {
    var response = await dio.get('', queryParameters: {
      'amount': maxquestions,
      'category': 18,
      'type': 'boolean',
      'difficulty': levels,
    });
    var data = jsonDecode(response.toString());
    questions = data['results'];
    notifyListeners();
  }

  String getCurrentQuestion() {
    return questions![currentQuestion]['question'];
  }

  void answerQuestion(String answer) async {
    bool isCorrect = questions![currentQuestion]['correct_answer'] == answer;
    correctCount += isCorrect ? 1 : 0;
    currentQuestion++;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.greenAccent : Colors.redAccent,
          title: Icon(
            isCorrect ? Icons.check_circle_outline : Icons.cancel_outlined,
            color: Colors.white,
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 1));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    if (currentQuestion == maxquestions) {
      endGame();
    } else {
      notifyListeners();
    }
  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "End Game!",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          content: Text("Score $correctCount/$maxquestions"),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
