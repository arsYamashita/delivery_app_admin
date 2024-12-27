import 'package:flutter/material.dart';

class ApiTestScreen extends StatelessWidget {
  const ApiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APIテスト画面'),
      ),
      body: const Center(
        child: Text('APIテスト画面'),
      ),
    );
  }
}
