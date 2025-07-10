// lib/screens/tasbih_screen.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({Key? key}) : super(key: key);

  @override
  _TasbihScreenState createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int _counter = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadCounter();
    _initializeAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // Initialize audio player
  Future<void> _initializeAudio() async {
    await _audioPlayer.setVolume(1.0);
  }

  // Load counter value from SharedPreferences
  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('tasbih_counter') ?? 0;
    });
  }

  // Save counter value to SharedPreferences
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tasbih_counter', _counter);
  }

  // Increment counter and play sound
  void _incrementCounter() async {
    await _audioPlayer.play(AssetSource('sounds/click_in.mp3'));
    setState(() {
      _counter++;
    });
    _saveCounter();
  }

  // Decrement counter
  void _decrementCounter() async {
    await _audioPlayer.play(AssetSource('sounds/click_di.mp3'));
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
      _saveCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasbih'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: _decrementCounter,
            tooltip: 'Decrease count',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _counter = 0;
              });
              _saveCounter();
            },
            tooltip: 'Reset counter',
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _incrementCounter,
        behavior: HitTestBehavior.opaque,
        child: Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    _counter.toString(),
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
