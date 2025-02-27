import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _themeData = ThemeData.light();

  void _toggleTheme() {
    setState(() {
      _themeData = (_themeData == ThemeData.light()) ? ThemeData.dark() : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      home: FadingTextAnimation(toggleTheme: _toggleTheme),
    );
  }
}

class FadingTextAnimation extends StatefulWidget {
  final VoidCallback toggleTheme;
  const FadingTextAnimation({super.key, required this.toggleTheme});

  @override
  _FadingTextAnimationState createState() => _FadingTextAnimationState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color _textColor = Colors.black;
  int _currentTextIndex = 0;

  final List<String> _texts = [
    "Hello, Flutter!",
    "Animations are cool!",
    "But hard to do :( )",
    "It was woth it tho!",
  ];

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
      _currentTextIndex = (_currentTextIndex + 1) % _texts.length;
    });
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pick a color"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _colorOption(Colors.red),
              _colorOption(Colors.blue),
              _colorOption(Colors.green),
            ],
          ),
        );
      },
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _textColor = color;
        });
        Navigator.of(context).pop();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fading Text Animation'),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/color_pallete_toggle.png',
              width: 30,
              height: 30,
            ),
            onPressed: _pickColor,
          ),
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Image.asset(
              'assets/day_night_toggle.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800), // Faster fade effect
          curve: Curves.easeInOut, // Smooth transition
          child: Text(
            _texts[_currentTextIndex], // Dynamic text change
            style: TextStyle(fontSize: 24, color: _textColor),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleVisibility,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
