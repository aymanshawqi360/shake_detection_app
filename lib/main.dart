import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const EventChannel _shakeChannel = EventChannel('shake_channel');
  String _quote = 'Shake your phone to get a motivational quote!';

  final List<String> _quotes = [
    'Believe in yourself!',
    'You can do hard things!',
    'Every step counts!',
    'Keep pushing forward!',
    'Dream big, work hard!',
    'Success starts with effort.',
  ];

  @override
  void initState() {
    super.initState();
    _shakeChannel.receiveBroadcastStream().listen((event) {
      _showRandomQuote();
    });
  }

  void _showRandomQuote() {
    final random = Random();
    setState(() {
      _quote = _quotes[random.nextInt(_quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: AppBar(
          title: const Text(
            'Shake for a Boost of Inspiration',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Text(
              _quote,
              key: ValueKey(_quote),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
