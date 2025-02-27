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
    "But hard to do :(",
    "It was worth it tho!",
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen(toggleTheme: widget.toggleTheme, pickColor: _pickColor)),
              );
            },
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          child: Text(
            _texts[_currentTextIndex],
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

class SecondScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final VoidCallback pickColor;

  const SecondScreen({super.key, required this.toggleTheme, required this.pickColor});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isVisible = true;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/color_pallete_toggle.png',
              width: 30,
              height: 30,
            ),
            onPressed: widget.pickColor,
          ),
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Image.asset(
              'assets/day_night_toggle.png',
              width: 30,
              height: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.swap_horiz),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: const Text(
                'Fading Text Animation 2',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleVisibility,
              child: const Text('Toggle Text Fade'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
