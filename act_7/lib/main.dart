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

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pick a color"),
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
        title: Text('Fading Text Animation'),
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
              // Navigate to SecondScreen
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SecondScreen()),
              ); 
            },
            icon: Icon(Icons.swap_horiz), // Swap screens icon
          ),

        ],
      ),
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, color: _textColor),
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
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isVisible = true; // Controls visibility of text

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 2), // Different duration
              child: Text(
                'Fading Text Animation 2',
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 20), // Adds spacing
            ElevatedButton(
              onPressed: toggleVisibility, // Toggle visibility
              child: Text('Toggle Text Fade'),
            ),
            SizedBox(height: 20), // Adds spacing
            ElevatedButton(
              onPressed: () {
                // Navigate back to the first screen
                Navigator.pop(context);
              },
              child: Text('Go Back'), // Back button
            ),
          ],
        ),
      ),
    );
  }
}