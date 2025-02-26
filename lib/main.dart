import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
home: FadingTextAnimation(),
);
}
}

class FadingTextAnimation extends StatefulWidget {
@override
_FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
bool _isVisible = true;
Color _textColor = Colors.black; // default text color

void toggleVisibility() {
setState(() {
_isVisible = !_isVisible;
});
}

 // Show a color picker dialog.
  void _showColorPicker() {
    Color tempColor = _textColor; // temporary color for the picker
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a text color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                tempColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                setState(() {
                  _textColor = tempColor;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Fading Text Animation'),
),
  
body: Center(
child: AnimatedOpacity(
opacity: _isVisible ? 1.0 : 0.0,
duration: Duration(seconds: 1),
child: Text(
'Hello, Flutter!',
style: TextStyle(fontSize: 24),
),
),
),
  
floatingActionButton: FloatingActionButton(
onPressed: toggleVisibility,
child: Icon(Icons.play_arrow),
),
);
}
}  
