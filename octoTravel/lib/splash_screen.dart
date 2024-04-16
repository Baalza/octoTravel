import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.25, 0.75, curve: Curves.easeInOut),
      ),
    );

    _sizeAnimation = Tween<double>(begin: 150, end: 350).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Avvia l'animazione
    _controller.forward();

    // Alla fine dell'animazione, naviga alla home page
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller
            .dispose(); // Cancella l'animazione prima di disporre del controller
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: AnimatedBuilder(
            animation: _sizeAnimation,
            builder: (context, child) {
              return Image.asset(
                'assets/images/polip.png',
                width: _sizeAnimation.value,
                height: _sizeAnimation.value,
              );
            },
          ),
        ),
      ),
    );
  }
}
