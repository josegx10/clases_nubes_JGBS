import 'package:flutter/material.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({super.key});

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  double _heigth = 150;
  double _width = 150;
  double _font = 25;

  void _updateState() {
    setState(() {
      _heigth = 300;
      _width = 300;
      _font = 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated'),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 900),
          curve: Curves.bounceOut,
          width: _width,
          height: _heigth,
          color: Colors.blueAccent,
          child: Center(
            child: Text('Hola',
                style: TextStyle(fontSize: _font, color: Colors.white)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateState();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
