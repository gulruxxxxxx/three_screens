import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_buildPageRoute(SecondScreen()));
          },
          child: Text('=> 2'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_buildPageRoute(ThirdScreen()));
          },
          child: Text('=> 3'),
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 10),
                reverseTransitionDuration: const Duration(seconds: 10),
                transitionsBuilder:
                    (_, animation, secondaryAnimation, child) {
                  return AnimatedBuilder(
                    animation: animation,
                    child:  FirstScreen(),
                    builder: (_, child) {
                      const begin = 0.0;
                      const end = 2 * pi;
                      var tween = Tween<double>(begin: begin, end: end);
                      return Transform.rotate(
                        angle: animation.drive(tween).value,
                        child: child,
                      );
                    },
                  );
                },
                pageBuilder: (_, animation, secondaryAnimation) {
                  return  FirstScreen();
                },
              ),
            );
            // Navigator.of(context).push(_buildPageRoute(FirstScreen()));
          },
          child: Text('=> 3'),
        ),
      ),
    );
  }
}

PageRouteBuilder _buildPageRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
      var offsetAnimation = animation.drive(tween);


      if (page is SecondScreen) {
        return ScaleTransition(
          scale: offsetAnimation,
          child: child,
        );
      }  else {
        return FadeTransition(
          opacity: offsetAnimation,
          child: child,
        );
      }
    },
  );
}
