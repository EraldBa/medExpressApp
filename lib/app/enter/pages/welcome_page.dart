import 'dart:math';

import 'package:flutter/material.dart';

import 'package:confetti/confetti.dart';
import 'package:lottie/lottie.dart';

import 'package:med_express/app/app.dart';
import 'package:med_express/app/home/pages/home_page.dart';
import 'package:med_express/services/user.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  static String get route => '/welcome-page';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 5),
  );

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: Colors.deepPurple,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Lottie.asset('assets/lottie/medical-frontliners.json'),
                  const SizedBox(height: 70.0),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      '✨Hello ${User.current.username}✨\n🥳🥳Welcome to ${App.name}!🥳🥳',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 25.0),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextButton(
                    onPressed: () {
                      _confettiController.stop();
                      Navigator.popAndPushNamed(context, HomePage.route);
                    },
                    child: const Text(
                      'Continue to Home Screen\t\t➡️',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ConfettiWidget(
          blastDirection: pi / 2,
          emissionFrequency: 0.05,
          minBlastForce: 8.0,
          confettiController: _confettiController,
        )
      ],
    );
  }
}
