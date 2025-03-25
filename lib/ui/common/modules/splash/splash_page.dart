import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adel_tarek/utils/router/route_names.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  String _route = RouteNames.rMainScreen;
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _textFadeAnimation;
  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeIn),
    );

    _logoAnimationController.forward();

    _logoAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _textAnimationController.forward();
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      startTime();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _textAnimationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _textFadeAnimation.value,
                  child: const Text(
                    "Meal Tracking App",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  startTime() async {
    Duration duration = const Duration(seconds: 2);
    _route = RouteNames.rMainScreen;

    return Timer(
        duration, () => Navigator.of(context).pushReplacementNamed(_route));
  }
}
