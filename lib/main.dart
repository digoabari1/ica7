import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(), // Default light theme
      darkTheme: ThemeData.dark(), // Dark theme
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
  bool _darkMode = false;
  bool _showSecondBody = false; // State to toggle between bodies

  void toggleTheme() {
    setState(() {
      _darkMode = !_darkMode;
    });
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void toggleBody() {
    setState(() {
      _showSecondBody = !_showSecondBody; // Toggle between bodies
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fading Text Animation'),
          actions: [
            IconButton(
              icon: Icon(
                _darkMode ? Icons.sunny : Icons.dark_mode_rounded,
                size: 40,
              ),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 500), // Animation duration
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation, // Fade transition
              child: child,
            );
          },
          child: _showSecondBody ? _buildSecondBody() : _buildFirstBody(), // Switch bodies
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: toggleBody, // Toggle between bodies
          child: Icon(Icons.swap_horiz), // Change icon to indicate switching
        ),
      ),
    );
  }

  // First Body Widget
  Widget _buildFirstBody() {
    return Center(
      key: ValueKey('FirstBody'), // Unique key for AnimatedSwitcher
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: Duration(seconds: 1),
            child: Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleVisibility,
            child: Text('Toggle Visibility'),
          ),
        ],
      ),
    );
  }

  // Second Body Widget
  Widget _buildSecondBody() {
    return SecondBody();
  }
}

// Second Body Widget with Color Picker
class SecondBody extends StatefulWidget {
  @override
  _SecondBodyState createState() => _SecondBodyState();
}

class _SecondBodyState extends State<SecondBody> {
  Color _textColor = Colors.black; // Default text color

  // Open color picker dialog
  void _openColorPicker() async {
    final Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (Color color) {
                setState(() {
                  _textColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(_textColor); // Return selected color
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (pickedColor != null) {
      setState(() {
        _textColor = pickedColor; // Update text color
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens), // Color palette icon
            onPressed: _openColorPicker, // Open color picker
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is the Second Body',
              style: TextStyle(
                fontSize: 24,
                color: _textColor, // Apply selected text color
              ),
            )
          ],
        ),
      ),
    );
  }
}