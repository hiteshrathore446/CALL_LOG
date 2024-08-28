import 'package:calllogapp/CallHistory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Callapp());
}

class Callapp extends StatelessWidget {
  const Callapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CallHistoryScreen(),
    );
  }
}
