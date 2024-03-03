import 'package:flutter/material.dart';
import 'package:frivia_app/providers/game_page_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class GamePage extends StatefulWidget {
  final String level;
  final int maxQuestion;
  const GamePage({super.key, required this.level, required this.maxQuestion});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double? _deviceHeight, _deviceWidth;

  GamePageProvider? pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(
        context: context,
        levels: widget.level,
        maxquestions: widget.maxQuestion,
      ),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (context) {
      pageProvider = context.watch<GamePageProvider>();
      if (pageProvider!.questions != null) {
        return Scaffold(
            body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
            child: _gameUI(),
          ),
        ));
      } else {
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      }
    });
  }

  // Widget _mainUI() {
  Widget _gameUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _questionText(),
          Column(
            children: [
              _trueButton(),
              SizedBox(height: _deviceHeight! * 0.02),
              _falseButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _questionText() {
    return Text(
      pageProvider!.getCurrentQuestion(),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 26,
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion('True');
      },
      color: Colors.green,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.08,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      hoverColor: const Color.fromARGB(255, 13, 112, 16),
      splashColor: Colors.black,
      child: const Text(
        "True",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        pageProvider!.answerQuestion('False');
      },
      color: Colors.red,
      minWidth: _deviceWidth! * 0.7,
      height: _deviceHeight! * 0.08,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
      hoverColor: const Color.fromARGB(255, 145, 17, 8),
      splashColor: Colors.black,
      child: const Text(
        "False",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    );
  }
}
