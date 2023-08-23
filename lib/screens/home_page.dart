// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static const NUMBER_OF_COLOR = 10;

  double x = 0;
  double y = 0;
  double z = 0;

  late AnimationController _controller;
  Color _generateColor() {
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  late final List<Color> colors;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colors = List.generate(NUMBER_OF_COLOR, (index) => _generateColor());
  }

  final Random random = Random(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 3),
        builder: (context, value, child) {
          return Container(
            child: Stack(
              children: [
                ...List.generate(
                  10,
                  (index) => Center(
                    child: Transform(
                      transform: Matrix4.identity()
                        // ..rotateX(0.1745329252)
                        ..rotateX(x + 0.02)
                        ..rotateY(y + 0.1745329252 * (index + 1) * 10 * value)
                        ..rotateZ(z),
                      alignment: FractionalOffset.center,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            y = y + details.delta.dx / 100;
                            x = x + details.delta.dy / 100;
                          });
                        },
                        child: Container(
                          color: colors[index],
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
