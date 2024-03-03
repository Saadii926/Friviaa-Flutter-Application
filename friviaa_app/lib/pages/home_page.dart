import 'package:flutter/material.dart';
import 'package:frivia_app/main.dart';
import 'package:frivia_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceHeight, deviceWidth;
  double currentlevel = 0;
  // int maxQuestions = 10;
  final List<String> level = ['Easy', 'Medium', 'Hard'];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _appTitle(),
                _slider(),
                _gameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50,
            letterSpacing: deviceWidth! * 0.02,
          ),
        ),
        Text(
          level[currentlevel.toInt()],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        Text(
          "Max Questions: ${currentlevel == 0 ? 10 : currentlevel == 1 ? 15 : 20}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget _slider() {
    return Slider(
      activeColor: Colors.blueGrey,
      inactiveColor: Colors.grey,
      thumbColor: Colors.blueAccent,
      mouseCursor: MouseCursor.defer,
      min: 0,
      max: 2,
      divisions: 2,
      label: "Difficulty",
      value: currentlevel,
      onChanged: (value) {
        setState(() {
          currentlevel = value;
        });
      },
    );
  }

  Widget _gameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Stack(
                children: [
                  const Background(),
                  GamePage(
                    level: level[currentlevel.toInt()].toLowerCase(),
                    maxQuestion: currentlevel == 0
                        ? 10
                        : currentlevel == 1
                            ? 15
                            : 20,
                  ),
                ],
              );
            },
          ),
        );
      },
      color: Colors.blue,
      hoverColor: Colors.lightBlue,
      minWidth: deviceHeight! * 0.80,
      height: deviceHeight! * 0.10,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Icon(
            Icons.gamepad,
            size: 24,
            color: Colors.white,
          ),
          SizedBox(
            width: deviceWidth! * 0.02,
          ),
          const Text(
            "Start",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
