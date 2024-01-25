import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _position = 0.0;
  static const double _maxPosition = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Transition and Reload State Example'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _position += details.primaryDelta!;
            _position = _position.clamp(-_maxPosition, _maxPosition);
          });
        },
        onHorizontalDragEnd: (details) {
          if (_position > _maxPosition / 2) {
            // You can put your logic here for state change
            _reloadState();
          } else if (_position < -_maxPosition / 2) {
            // You can put your logic here for state change
            _reloadState();
          } else {
            setState(() {
              _position = 0.0;
            });
          }
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          transform: Matrix4.translationValues(_position, 0, 0),
          child: Center(
            child: Text(
              'Drag Left/Right to Reload State',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  void _reloadState() {
    setState(() {
     
      _position = 0.0;
    });
  }
}
